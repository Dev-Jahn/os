#include <list.h>
#include <proc/sched.h>
#include <mem/malloc.h>
#include <proc/proc.h>
#include <proc/switch.h>
#include <interrupt.h>
#include <device/console.h>

extern struct list level_que[QUE_LV_MAX];
extern struct list plist;
extern struct list slist;
extern struct process procs[PROC_NUM_MAX];
extern struct process *idle_process;
unsigned long total;

struct process *latest;

struct process* get_next_proc(struct list *rlist_target);
void proc_que_levelup(struct process *cur);
void proc_que_leveldown(struct process *cur);
struct process* sched_find_que(void);

int scheduling;

/*
	linux multilevelfeedback queue scheduler
	level 1 que policy is FCFS(First Come, First Served)
	level 2 que policy is RR(Round Robin).
*/

//sched_find_que find the next process from the highest queue that has proccesses.
struct process* sched_find_que(void) {
	int i,j;
	struct process * result = NULL;
	 
	proc_wake();
	
	//if lv1 que is not empty
	if (!list_empty(&level_que[1]))
		result = get_next_proc(&level_que[1]);
	//if lv2 que is not empty
	else if (!list_empty(&level_que[2]))
		result = get_next_proc(&level_que[2]);

	return result;
}

struct process* get_next_proc(struct list *rlist_target) {
	struct list_elem *e;

	for(e = list_begin (rlist_target); e != list_end (rlist_target);
		e = list_next (e))
	{
		struct process* p = list_entry(e, struct process, elem_stat);

		if(p->state == PROC_RUN)
			return p;
	}
	return NULL;
}
void schedule(void)
{
	struct process *cur;
	struct process *next;
	struct process *tmp;
	struct list_elem *ele;
	int i = 0, printed = 0;

	intr_disable();
	scheduling = 1;	
	cur = cur_process;
	/*TODO : if current process is idle_process(pid 0), schedule() choose the next process (not pid 0).
	when context switching, you can use switch_process().  
	if current process is not idle_process, schedule() choose the idle process(pid 0).
	complete the schedule() code below.
	*/
	if ((cur -> pid) != 0) {
		if (cur->time_slice == LV0_TIMER+1 ||
			cur->time_slice == LV1_TIMER+1) {
			cur->time_slice--;
			cur->time_used--;
		}
		next = idle_process;
		cur_process = next;
		intr_enable();
		scheduling = 0;
		switch_process(cur, next);
		return;
	}
	if (latest) {
		total += latest->time_slice;
		printk("Global elapsed: %d\n", total);
		if (latest->state == PROC_ZOMBIE) {
			printk("Proc%d end\n", latest->pid);
			latest = 0;
		}
		else if (latest->state == PROC_STOP) {
			printk("Proc%d I/O at %d\n", latest->pid, latest->time_used);
			printk("Proc%d 's que is 1\n");
		if (latest->que_level != 1)
			printk("Proc%d change the queue (2->1)\n", latest->pid);
		}
		else {
			switch (latest -> que_level) {
			//idle
			case 0:
				break;
			case 1:
				//If tq exceeded, send to lv2.
				if (latest->state == PROC_RUN && latest->time_slice >= LV0_TIMER)
				{
					proc_que_leveldown(latest);
					list_push_back(&level_que[2], list_pop_front(&level_que[1]));
				}
				//schedule() called for some other reason(Not I/O), go back to latest
				else if (latest->state != PROC_STOP)
				{
					cur_process = latest;
					intr_enable();
					scheduling = 0;
					switch_process(cur, latest);
				}
				break;
			//lv2. Scheduled but, 
			case 2:
				//If tq exceeded, stay
				if (latest->state == PROC_RUN && latest->time_slice >= LV1_TIMER)
					list_push_back(&level_que[2], &latest->elem_stat);
				//schedule() called for some other reason(Not I/O), go back to latest
				else if (latest->state != PROC_STOP)
				{
					cur_process = latest;
					intr_enable();
					scheduling = 0;
					switch_process(cur, latest);
				}
				break;
			default:
				break;
			}
		}
	}

	proc_wake(); //wake up the process whose io is finished

	//print the info of all 10 proc.
	for (ele = list_begin(&plist); ele != list_end(&plist); ele = list_next(ele)) {
		tmp = list_entry (ele, struct process, elem_all);
		if ((tmp -> state == PROC_ZOMBIE) || 
			//(tmp -> state == PROC_BLOCK) || 
			//	(tmp -> state == PROC_STOP) ||
					(tmp -> pid == 0)) 	continue;
			if (!printed) {	
				printk("#=%2d t=%3d u=%3d ", tmp -> pid, tmp -> time_slice, tmp -> time_used);
				printk("q=%3d", tmp->que_level);
				printed = 1;			
			}
			else {
				printk(", #=%2d t=%3d u=%3d ", tmp -> pid, tmp -> time_slice, tmp->time_used);
				printk("q=%3d", tmp->que_level);
				}
			
	}

	if (printed)
		printk("\n");

	if ((next = sched_find_que()) != NULL) {
		printk("Selected process : %d\n", next -> pid);
		printk("#### Switching... ####\n");
		cur_process = next;
		cur_process->time_slice = 0;
		latest = next;
		intr_enable();
		scheduling = 0;
		switch_process(cur, next);
		return;
	}
	intr_enable();
	scheduling = 0;
	return;
}

void proc_que_levelup(struct process *cur)
{
	cur->que_level = 1;
	printk("Proc%d change the queue(2->1)\n", latest->pid);
}

void proc_que_leveldown(struct process *cur)
{
	cur->que_level = 2;
	printk("Proc%d change the queue(1->2)\n", latest->pid);
}
