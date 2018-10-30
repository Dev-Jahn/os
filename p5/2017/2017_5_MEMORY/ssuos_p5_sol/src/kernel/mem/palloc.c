#include <mem/palloc.h>
#include <bitmap.h>
#include <type.h>
#include <round.h>
#include <mem/mm.h>
#include <synch.h>
#include <device/console.h>
#include <mem/paging.h>

struct khpage{
	uint16_t page_type;
	uint16_t nalloc;
	uint32_t used_bit[4];
	struct khpage *next;
};

struct freelist{
	struct khpage *list;
	int nfree;
};

static struct khpage *khpage_list;
static struct freelist freelist;
static uint32_t page_alloc_index;

	void
init_palloc (void) 
{
	size_t bm_size = sizeof(struct khpage) * 1024;

	khpage_list = (struct khpage *)(KERNEL_ADDR);

	memset((void*)khpage_list, 0, bm_size);
	page_alloc_index = 0;
	freelist.list = NULL;
	freelist.nfree = 0;
}

	uint32_t *
palloc_get_multiple (size_t page_cnt)
{
	void *pages = NULL;
	struct khpage *khpage = freelist.list;
	struct khpage *prepage = freelist.list;
	size_t page_idx;

	if (page_cnt == 0)
		return NULL;

	while(khpage != NULL){
		if(khpage->nalloc == page_cnt){
			page_idx = ((uint32_t)khpage - (uint32_t)khpage_list)/sizeof(struct khpage);
			pages = (void*)(VKERNEL_HEAP_START + page_idx * PAGE_SIZE);

			if(prepage == khpage){
				freelist.list = khpage->next;
				freelist.nfree--;
				break;
			}else{
				prepage->next = khpage->next;
				freelist.nfree--;
				break;
			}
				   	
		}
		prepage = khpage;
		khpage = khpage->next;
	}

	if(pages == NULL){
		pages = (void*)(VKERNEL_HEAP_START + page_alloc_index * PAGE_SIZE);
		page_alloc_index += page_cnt;
	}

	if (pages != NULL) 
	{
		memset (pages, 0, PAGE_SIZE * page_cnt);
	}

	return (uint32_t*)pages; 
}

	uint32_t *
palloc_get_page (void) 
{
	return palloc_get_multiple (1);
}

	void
palloc_free_multiple (void *pages, size_t page_cnt) 
{
	struct khpage *khpage = freelist.list;
	//가상주소상 몇번째 페이지인지
	size_t page_idx = (((uint32_t)pages - VKERNEL_HEAP_START) / PAGE_SIZE);

	if (pages == NULL || page_cnt == 0)
		return;
	//
	if(khpage == NULL){
		freelist.list = khpage_list + page_idx;
		freelist.list->nalloc = page_cnt;
		freelist.list->next = NULL;
	}
	else{

		while(khpage->next != NULL){
			khpage = khpage->next;
		}

		khpage->next = khpage_list + page_idx;
		khpage->next->nalloc = page_cnt;
		khpage->next->next = NULL;
	}

	freelist.nfree++;
}

	void
palloc_free_page (void *page) 
{
	palloc_free_multiple (page, 1);
}

void palloc_pf_test(void)
{
	uint32_t *one_page1 = palloc_get_page();
	uint32_t *one_page2 = palloc_get_page();
	uint32_t *two_page1 = palloc_get_multiple(2);
	uint32_t *three_page;
	printk("one_page1 = %x\n", one_page1); 
	printk("one_page2 = %x\n", one_page2); 
	printk("two_page1 = %x\n", two_page1);

	printk("=----------------------------------=\n");
	palloc_free_page(one_page1);
	palloc_free_page(one_page2);
	palloc_free_multiple(two_page1,2);

	one_page1 = palloc_get_page();
	two_page1 = palloc_get_multiple(2);
	one_page2 = palloc_get_page();

	printk("one_page1 = %x\n", one_page1);
	printk("one_page2 = %x\n", one_page2);
	printk("two_page1 = %x\n", two_page1);

	printk("=----------------------------------=\n");
	palloc_free_multiple(one_page2, 3);
	one_page2 = palloc_get_page();
	three_page = palloc_get_multiple(3);

	printk("one_page1 = %x\n", one_page1);
	printk("one_page2 = %x\n", one_page2);
	printk("three_page = %x\n", three_page);

	palloc_free_page(one_page1);
	palloc_free_page(three_page);
	three_page = (uint32_t*)((uint32_t)three_page + 0x1000);
	palloc_free_page(three_page);
	three_page = (uint32_t*)((uint32_t)three_page + 0x1000);
	palloc_free_page(three_page);
	palloc_free_page(one_page2);
}