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
					if (kpage->vaddr>=VKERNEL_STACK_ADDR)
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
				pages = ra_to_va(RKERNEL_HEAP_START+
							(page_alloc_index+page_cnt-1)*PAGE_SIZE);
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
				if(kpage->type == FREE__ && kpage->nalloc == page_cnt)
					break;
			if (i==1024)
				return NULL;
			kpage->type = STACK__;
			kpage->nalloc = page_cnt;
			kpage->pid = cur_process->pid;
			kpage->vaddr = pages = (void*)VKERNEL_STACK_ADDR;
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

	if (pages == NULL || page_cnt == 0)
		return;
	
	//Linear search for kpage where pages are in.
	for (int i=0;kpage->type!=0 && i<1024;i++,kpage+=sizeof(struct kpage))
		if (kpage->vaddr == pages && kpage->nalloc == page_cnt)
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
	if (va < RKERNEL_HEAP_START)
		return va;
	else
		return VH_TO_RH(va);
}

	uint32_t *
ra_to_va (uint32_t *ra){
	if (ra < RKERNEL_HEAP_START)
		return ra;
	else
		return RH_TO_VH(ra);
}

void palloc_pf_test(void)
{
	printk("Test start\n");
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
