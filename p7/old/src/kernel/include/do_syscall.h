#ifndef	   __DO_SYSCALL_H__
#define	   __DO_SYSCALL_H__

#define OPT_E 0x100
#define OPT_RE 0x200
#define OPT_A 0x400
#define OPT_C 0x800
#define ON_E(whence) OPT_E & (whence)
#define ON_RE(whence) OPT_RE & (whence)
#define ON_A(whence) OPT_A & (whence)
#define ON_C(whence) OPT_C & (whence)



pid_t do_fork(proc_func func, void* aux1, void* aux2);
void do_exit(int status);
pid_t do_wait(int *status);
int do_ssuread(int type, char* buf, int len);
void do_shutdown(void);
int do_open(const char *pathname, int flags);
int do_read(int fd, char *buf, int len);
int do_write(int fd, const char *buf, int len);
int do_lseek(int fd, int offset, int whence);

#endif
