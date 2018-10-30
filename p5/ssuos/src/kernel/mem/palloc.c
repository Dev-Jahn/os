#include <mem/palloc.h>
#include <bitmap.h>
#include <type.h>
#include <round.h>
#include <mem/mm.h>
#include <synch.h>
#include <device/console.h>
#include <mem/paging.h>
#include <proc/proc.h>
#include <stdbool.h>
#include <interrupt.h>

#define STACK_PAGES 2
#define STACK_MASK 0xFFFFE000
/* Page allocator.  Hands out memory in page-size (or
   page-multiple) chunks.  
   */

/* page struct */
struct kpage{
	uint32_t type;
	uint32_t *vaddr;
	uint32_t nalloc;
	pid_t pid;
};


static struct kpage *kpage_list;
static uint32_t page_alloc_index;

/* Initializes the page allocator. */
	void
init_palloc (void) 
{
	/* Calculate the space needed for the kpage list */
	size_t pool_size = sizeof(struct kpage) * PAGE_POOL_SIZE;

	/* kpage list alloc */
	kpage_list = (struct kpage *)(KERNEL_ADDR);

	/* initialize */
	memset((void*)kpage_list, 0, pool_size);
	page_alloc_index = 0;
}

/* Obtains and returns a group of PAGE_CNT contiguous free pages.
   */
	uint32_t *
palloc_get_multiple (uint32_t page_type, size_t page_cnt)
{
	void *pages = NULL;
	struct kpage *kpage = kpage_list;
	int i,j;

	if (page_cnt == 0)
		return NULL;

	switch(page_type){
		case HEAP__:
			//Find fitting kpage to allocate
			for (i=0;kpage->type!=0&&i<1024;
					i++,kpage+=sizeof(struct kpage))
				if(kpage->type == FREE__ && kpage->nalloc == page_cnt)
				{
					if (kpage->vaddr>=VKERNEL_STACK_ADDR &&
							kpage->vaddr<=VKERNEL_HEAP_START)
						pages = kpage->vaddr;
					//if kpage was previously not heap, allocate new
					break;
				}
			if (i == 1024)	//if kpage full
				return NULL;

			kpage->type = HEAP__;
			kpage->pid = cur_process->pid;
			//If not found add new kpage
			if (pages == NULL)
			{
				pages = VKERNEL_HEAP_START - (page_alloc_index + page_cnt)*PAGE_SIZE;
				kpage->vaddr = pages;
				kpage->nalloc = page_cnt;
				page_alloc_index += page_cnt;
			}
			/*printk("\tHEAP:%X\n", pages);*/
			break;
		case STACK__: 
			//Find fitting kpage to allocate
			for (i=0;kpage->type!=0 && i<1024;
					i++,kpage+=sizeof(struct kpage))
				if(kpage->type == FREE__ && kpage->nalloc == page_cnt &&
						kpage->vaddr == (uint32_t*)VKERNEL_STACK_ADDR)
					break;
			if (i==1024)
				return NULL;
			kpage->type = STACK__;
			kpage->nalloc = page_cnt;
			kpage->pid = cur_process->pid;
			pages = (void*)VKERNEL_STACK_ADDR;
			kpage->vaddr = pages;
			break;
		default:
			return NULL;
	}
	if (pages != NULL)
	{
		if (page_type == HEAP__) 
			memset(pages, 0, PAGE_SIZE * page_cnt);
		else if (page_type == STACK__)
			memset(pages - PAGE_SIZE*STACK_PAGES, 0, PAGE_SIZE*STACK_PAGES);
	}
#ifdef TEST
	if (page_type == HEAP__)
		printk("\tHEAP:%X(%dpage)\n",pages, page_cnt);
	if (page_type == STACK__)
		printk("\tSTACK:%X(%dpage)\n",pages, page_cnt);
	printk("\t\talloc ra:%X\n",va_to_ra(pages));
#endif
		
	return (uint32_t*)pages; 
}

/* Obtains a single free page and returns its address.
   */
	uint32_t *
palloc_get_page (uint32_t page_type) 
{
	return palloc_get_multiple (page_type, 1);
}

/* Frees the PAGE_CNT pages starting at PAGES. */
	void
palloc_free_multiple (void *pages, size_t page_cnt) 
{
	bool found = false;
	struct kpage *kpage = kpage_list;
	uint32_t* target = pages;
	if (pages == NULL || page_cnt == 0)
		return;
	
	if ((uint32_t)pages < VKERNEL_STACK_ADDR)
	{
		target = (uint32_t*)(((uint32_t)pages & (uint32_t)STACK_MASK)
								+ (uint32_t)0x2000);
	}
	//Linear search for kpage where pages are in.
	for (int i=0;kpage->type!=0 && i<1024;i++,kpage+=sizeof(struct kpage))
		if (kpage->vaddr == target && kpage->nalloc == page_cnt)
		{
			kpage->type = FREE__;
			found = true;
			return;
		}
	//If address doesn't fit to kpage
	if (!found)
	{
		printk("out of bound\n");
		return;
	}
}
/* Frees the page at PAGE. */
	void
palloc_free_page (void *page) 
{
	palloc_free_multiple (page, 1);
}


	uint32_t *
va_to_ra (uint32_t *va){
	struct kpage *kp = kpage_list;
	uint32_t hi = (uint32_t)va & PAGE_MASK_BASE;
	uint32_t lo = (uint32_t)va & ~PAGE_MASK_BASE;
	size_t sum = 0;
	int flag = 0;
	
	if (va < RKERNEL_HEAP_START)
		return va;
	if ((uint32_t)va < VKERNEL_STACK_ADDR)
	{
		lo = PAGE_SIZE*2 - (VKERNEL_STACK_ADDR - (uint32_t)va);
		hi = VKERNEL_STACK_ADDR;
	}
	int i;
	for (i=0;kp->type!=0 && i<1024;i++)
	{
		if (kp->vaddr == (uint32_t*)hi)
		{
			if (kp->type == STACK__)
			{
				if(kp->pid == cur_process->pid)
				{
					flag = 1;
					break;
				}
			}
			else
				break;
		}
		sum += kp->nalloc;
		kp+=sizeof(struct kpage);
	}
	if (kp->type == 0 || i ==1024)
	{
		/*printk("meh..\n");*/
		return NULL;
	}
	/*printk("\tra:%X\n",(uint32_t*)(RKERNEL_HEAP_START + PAGE_SIZE*sum + lo));*/
	if (flag)
	{
		printk("va:%X\n", va);
		printk("ra:%X\n", (uint32_t*)(RKERNEL_HEAP_START + PAGE_SIZE*sum + lo));
		/*printk("va>ra>va:%X\n", ra_to_va((uint32_t*)(RKERNEL_HEAP_START + PAGE_SIZE*sum + lo)));*/
	}
	return (uint32_t*)(RKERNEL_HEAP_START + PAGE_SIZE*sum + lo);
}
 

	uint32_t *
ra_to_va (uint32_t *ra){
	struct kpage *kp = kpage_list;
	uint32_t hi = (uint32_t)ra & PAGE_MASK_BASE;
	uint32_t lo = (uint32_t)ra & ~PAGE_MASK_BASE;
	size_t npages, sum = 0;
	/*printk(("ra:%X\n",(uint32_t)ra));*/
	if (ra < RKERNEL_HEAP_START)
		return ra;
	else
	{
		int i;
		npages = (hi - RKERNEL_HEAP_START)/PAGE_SIZE;
		for (i=0;kp->type!=0 && i<1024;i++)
		{
			if (sum == npages)
				break;
			sum += kp->nalloc;
			kp+=sizeof(struct kpage);
		}
		if (kp->type == 0 || i ==1024)
			return NULL;
		return kp->vaddr + lo;
	}
}

void palloc_pf_test(void)
{
	uint32_t *one_page1 = palloc_get_page(HEAP__);
	uint32_t *one_page2 = palloc_get_page(HEAP__);
	uint32_t *two_page1 = palloc_get_multiple(HEAP__,2);
	uint32_t *three_page;
	printk("one_page1 = %x\n", one_page1); 
	printk("one_page2 = %x\n", one_page2); 
	printk("two_page1 = %x\n", two_page1);

	printk("=----------------------------------=\n");
	palloc_free_page(one_page1);
	palloc_free_page(one_page2);
	palloc_free_multiple(two_page1,2);

	one_page1 = palloc_get_page(HEAP__);
	two_page1 = palloc_get_multiple(HEAP__,2);
	one_page2 = palloc_get_page(HEAP__);

	printk("one_page1 = %x\n", one_page1);
	printk("one_page2 = %x\n", one_page2);
	printk("two_page1 = %x\n", two_page1);

	printk("=----------------------------------=\n");
	three_page = palloc_get_multiple(HEAP__,3);

	printk("three_page = %x\n", three_page);
	palloc_free_page(one_page1);
	palloc_free_page(one_page2);
	palloc_free_multiple(two_page1,2);
	palloc_free_multiple(three_page, 3);
}
