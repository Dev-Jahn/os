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
	if (list_begin(&level_que[1]) != list_tail(&level_que[1]))
		result = get_next_proc(&level_que[1]);
	//if lv2 que is not empty
	else if (list_begin(&level_que[2]) == list_tail(&level_que[2]))
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

	scheduling = 1;	
	cur = cur_process;
	/*TODO : if current process is idle_process(pid 0), schedule() choose the next process (not pid 0).
	when context switching, you can use switch_process().  
	if current process is not idle_process, schedule() choose the idle process(pid 0).
	complete the schedule() code below.
	*/
	if ((cur -> pid) != 0) {
		next = list_entry(list_begin(&level_que[0]), struct process, elem_stat);
		cur_process = next;
		cur_process->time_slice = 0;
		switch_process(cur, next);
		scheduling = 0;
		return;
	}
	switch (latest -> que_level) {
	//idle
	case 0:
		break;
	//lv1
	case 1:
		if (latest->state == PROC_RUN)
			proc_que_leveldown(latest);
		break;
	//lv2
	case 2:
		if (latest->state == PROC_STOP)
			proc_que_levelup(latest);
		break;
	default:
		break;
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
				printk("q=%3d\n", tmp->que_level);
				printed = 1;			
			}
			else {
				printk(", #=%2d t=%3d u=%3d ", tmp -> pid, tmp -> time_slice, tmp->time_used);
				printk("q=%3d\n", tmp->que_level);
				}
			
	}

	if (printed)
		printk("\n");

	if ((next = sched_find_que()) != NULL) {
		printk("Selected process : %d\n", next -> pid);
		cur_process = next;
		cur_process->time_slice = 0;
		latest = next;
		switch_process(cur, next);
		scheduling = 0;
		return;
	}
	return;
}

void proc_que_levelup(struct process *cur)
{
	cur->que_level = 1;
	/*TODO : change the queue lv2 to queue lv1.*/
}

void proc_que_leveldown(struct process *cur)
{
	cur->que_level = 2;
	/*TODO : change the queue lv1 to queue lv2.*/
}
