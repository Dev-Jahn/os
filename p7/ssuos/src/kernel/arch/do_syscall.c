#include <syscall.h>
#include <proc/sched.h>
#include <proc/proc.h>
#include <device/device.h>
#include <interrupt.h>
#include <device/kbd.h>
#include <filesys/file.h>
#include <string.h>

pid_t do_fork(proc_func func, void* aux1, void* aux2)
{
	pid_t pid;
	struct proc_option opt;

	opt.priority = cur_process-> priority;
	pid = proc_create(func, &opt, aux1, aux2);

	return pid;
}

void do_exit(int status)
{
	cur_process->exit_status = status; 	//종료 상태 저장
	proc_free();						//프로세스 자원 해제
	do_sched_on_return();				//인터럽트 종료시 스케줄링
}

pid_t do_wait(int *status)
{
	while(cur_process->child_pid != -1)
		schedule();
	//SSUMUST : schedule 제거.

	int pid = cur_process->child_pid;
	cur_process->child_pid = -1;

	extern struct process procs[];
	procs[pid].state = PROC_UNUSED;

	if(!status)
		*status = procs[pid].exit_status;

	return pid;
}

void do_shutdown(void)
{
	dev_shutdown();
	return;
}

int do_ssuread(void)
{
	return kbd_read_char();
}

int do_open(const char *pathname, int flags)
{
	struct inode *inode;
	struct ssufile **file_cursor = cur_process->file;
	int fd;

	for(fd = 0; fd < NR_FILEDES; fd++)
		if(file_cursor[fd] == NULL) break;

	if (fd == NR_FILEDES)
		return -1;

	if ( (inode = inode_open(pathname)) == NULL)
		return -1;
	
	if (inode->sn_type == SSU_TYPE_DIR)
		return -1;

	fd = file_open(inode,flags,0);
	
	return fd;
}

int do_read(int fd, char *buf, int len)
{
	return generic_read(fd, (void *)buf, len);
}
int do_write(int fd, const char *buf, int len)
{
	return generic_write(fd, (void *)buf, len);
}
#include <device/console.h>
int do_lseek(int fd, int offset, int whence)
{
	struct ssufile *cursor = cur_process->file[fd];
	uint16_t *pos, tmp; 
	uint32_t size = cursor->inode->sn_size;
	char buf[BUFSIZ];
	memset(buf, 0, BUFSIZ);
	if (cursor == NULL)
		return -1;

	pos = &(cur_process->file[fd]->pos);
	switch (whence & ~OPTMASK)
	{
		case SEEK_SET:
			tmp = 0;
			break;
		case SEEK_CUR:
			tmp = *pos;
			break;
		case SEEK_END:
			tmp = size;
			break;
		default:
			break;
	}
	//우로 초과
	if ((int)tmp + offset > (int)size)
	{
		if (ON_E(whence))
		{
			file_write(cursor->inode, size, buf, tmp+offset-size);
			*pos = tmp + offset;
		}
		else if (ON_C(whence))
			*pos = tmp + offset - size;
		else
			return -1;
	}
	//좌로 초과
	else if ((int)tmp + offset < 0)
	{
		if (ON_RE(whence))
		{
			file_read(cursor->inode, 0, buf-(tmp+offset), size);
			file_write(cursor->inode, 0, buf, size-(tmp+offset));
			*pos = 0;
		}
		else if (ON_C(whence))
			*pos = tmp + offset + size;
		else
			return -1;
	}
	//a 옵션
	else if (ON_A(whence))
	{
		//입력오프셋이 현재 오프셋 보다 작을때 예외
		if (tmp+offset < *pos)
			return -1;
		file_read(cursor->inode, 0, buf, *pos);
		file_read(cursor->inode, *pos, buf+tmp+offset, size-*pos);
		file_write(cursor->inode, 0, buf, size+tmp+offset-*pos);
	}
	else
		*pos = tmp + offset;
	return *pos;
}
