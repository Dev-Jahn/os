#include <device/console.h>
#include <filesys/procfs.h>
#include <filesys/vnode.h>
#include <proc/proc.h>
#include <list.h>
#include <string.h>
#include <ssulib.h>

#define is_digit(c)	( (c) > '0' && (c) < '9' )

extern struct list p_list;
extern struct process *cur_process;
static int atoi(const char **s);

struct vnode *init_procfs(struct vnode *mnt_vnode)
{
	mnt_vnode->v_op.ls = proc_process_ls;
	mnt_vnode->v_op.mkdir = NULL;
	mnt_vnode->v_op.cd = proc_process_cd;

	return mnt_vnode;
}

int proc_process_ls()
{
	int result = 0;
	struct list_elem *e;

	printk(". .. ");
	for(e = list_begin (&p_list); e != list_end (&p_list); e = list_next (e))
	{
		struct process* p = list_entry(e, struct process, elem_all);

		printk("%d ", p->pid);
	}
	printk("\n");

	return result;
}

int proc_process_cd(char *dirname)
{
	struct vnode *new_vnode;
	struct process *p = get_process(atoi((const char**)&dirname));
	new_vnode = vnode_alloc();
	new_vnode->v_parent = cur_process->cwd;
	prints(new_vnode->v_name, "%d", p->pid);
	new_vnode->v_op.ls = proc_process_info_ls;
	new_vnode->v_op.cd = proc_process_info_cd;
	new_vnode->v_op.cat = proc_process_info_cat;
	list_push_back(&cur_process->cwd->childlist, &new_vnode->elem);

	struct vnode *cwd = vnode_alloc();
	cwd->v_op.ls = proc_link_ls;
	memcpy(cwd->v_name, "cwd", sizeof("cwd"));
	cwd->v_parent = new_vnode;
	cwd->type = p->cwd->type;
	cwd->v_op = p->cwd->v_op;
	cwd->v_op.ls = proc_link_ls;
	cwd->info = p->cwd->info;
	cwd->childlist = p->cwd->childlist;
	list_push_back(&new_vnode->childlist, &cwd->elem);

	struct vnode *root = vnode_alloc();
	root->v_op.ls = proc_link_ls;
	memcpy(root->v_name, "root", sizeof("root"));
	root->v_parent = new_vnode;
	root->type = p->rootdir->type;
	root->v_op = p->rootdir->v_op;
	root->v_op.ls = proc_link_ls;
	root->info = p->rootdir->info;
	root->childlist = p->rootdir->childlist;
	list_push_back(&new_vnode->childlist, &root->elem);

	cur_process->cwd = new_vnode;
	return 0;
}

int proc_process_info_ls()
{
	int result = 0;

	printk(". .. ");
	printk("cwd root time stack");

	printk("\n");

	return result;
}

static int atoi(const char **s)
{
	int i=0;

	while (is_digit(**s))
	{
		i = i*10 + *((*s)++) - '0';
	}
	return i;
}

int proc_process_info_cd(char *dirname)
{
	struct list_elem *e;
	struct vnode *cwd = cur_process->cwd;
	struct vnode *child;
	for(e = list_begin (&cwd->childlist); e != list_end (&cwd->childlist); e = list_next (e))
	{
		child = list_entry(e, struct vnode, elem);

		if(strcmp(child->v_name, dirname) == 0){
			if(child->type == DIR_TYPE){
				cur_process->cwd = child;
			}else{
				printk("%s is not a directory\n", dirname);
			}
			return 0;
		}
	}
	printk("There's no directory %s\n", dirname);
	return -1;
}

int proc_process_info_cat(char *filename)
{
	const char *tmp = cur_process->cwd->v_name;
	struct process *p = get_process(atoi(&tmp));
	if (!strcmp("time", filename))
		printk("time_used : %d\n", p->time_used);
	else if (!strcmp("stack", filename))
		printk("stack : %x\n", p->stack);
	else
		printk("Can't do cat to %s\n", filename);
	return 0;
}

#include <filesys/ssufs.h>
static int num_direntry(struct ssufs_inode *inode)
{
	if(inode->i_size % sizeof(struct dirent) != 0)
	/*if(inode->i_size % sizeof(struct dirent) != 0 || inode->i_type != SSU_DIR_TYPE)*/
		return -1;

	return inode->i_size / sizeof(struct dirent);
}
int proc_link_ls()
{
	struct vnode *cwd = cur_process->cwd;
	struct list_elem *e = list_begin(&cwd->childlist);
	struct vnode *child;
	printk(". .. ");
	int count = num_direntry(cwd->info);
	for (int i=0;i<count-2;i++,e=list_next(e))
	{
		child = list_entry(e, struct vnode, elem);
		printk("%s ", child->v_name);
	}
	printk("\n");
	return 0;
}
