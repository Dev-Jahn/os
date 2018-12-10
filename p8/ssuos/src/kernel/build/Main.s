	.file	"Main.c"
	.text
.Ltext0:
	.comm	Glob_x,4,4
	.comm	Glob_y,4,4
	.comm	ata0_blk_dev,20,4
	.comm	ata1_blk_dev,20,4
	.local	filesys
	.comm	filesys,44,32
	.comm	inode_tbl,16384,32
	.comm	ata,56,32
	.globl	VERSION
	.section	.rodata
.LC0:
	.string	"0.1.07"
	.section	.data.rel.local,"aw",@progbits
	.align 4
	.type	VERSION, @object
	.size	VERSION, 4
VERSION:
	.long	.LC0
	.globl	AUTHOR
	.section	.rodata
.LC1:
	.string	"OSLAB"
	.section	.data.rel.local
	.align 4
	.type	AUTHOR, @object
	.size	AUTHOR, 4
AUTHOR:
	.long	.LC1
	.globl	MODIFIER
	.section	.rodata
.LC2:
	.string	"You"
	.section	.data.rel.local
	.align 4
	.type	MODIFIER, @object
	.size	MODIFIER, 4
MODIFIER:
	.long	.LC2
	.text
	.globl	ssuos_main
	.type	ssuos_main, @function
ssuos_main:
.LFB3:
	.file 1 "arch/Main.c"
	.loc 1 29 0
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 30 0
	call	main_init
	.loc 1 32 0
	subl	$12, %esp
	pushl	$0
	call	idle@PLT
	addl	$16, %esp
	.loc 1 34 0
	nop
	.loc 1 35 0
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	ssuos_main, .-ssuos_main
	.section	.rodata
.LC3:
	.string	"Memory Detecting"
.LC4:
	.string	"%s"
.LC5:
	.string	"\n-Memory size = %u Kbytes\n"
.LC6:
	.string	"PIT Intialization\n"
.LC7:
	.string	"System call Intialization\n"
.LC8:
	.string	"Interrupt Initialization\n"
.LC9:
	.string	"%sPalloc Initialization\n"
.LC10:
	.string	"Paging Initialization\n"
.LC11:
	.string	"Process Intialization\n"
.LC12:
	.string	"ATA device Intialization\n"
	.align 4
.LC13:
	.string	"========== initialization complete ==========\n\n"
	.text
	.globl	main_init
	.type	main_init, @function
main_init:
.LFB4:
	.loc 1 38 0
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 39 0
	call	intr_disable@PLT
	.loc 1 42 0
	call	init_console@PLT
	.loc 1 44 0
	call	print_contributors
	.loc 1 46 0
	call	detect_mem@PLT
	.loc 1 47 0
	subl	$8, %esp
	leal	.LC3@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 48 0
	call	mem_size@PLT
	shrl	$10, %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC5@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 50 0
	call	init_pit@PLT
	.loc 1 51 0
	subl	$8, %esp
	leal	.LC6@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 53 0
	call	init_syscall@PLT
	.loc 1 54 0
	subl	$8, %esp
	leal	.LC7@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 56 0
	call	init_intr@PLT
	.loc 1 57 0
	subl	$8, %esp
	leal	.LC8@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 59 0
	call	init_kbd@PLT
	.loc 1 61 0
	call	init_palloc@PLT
	.loc 1 62 0
	subl	$12, %esp
	leal	.LC9@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 64 0
	call	init_paging@PLT
	.loc 1 65 0
	subl	$8, %esp
	leal	.LC10@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 67 0
	call	init_proc@PLT
	.loc 1 68 0
	subl	$8, %esp
	leal	.LC11@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 70 0
	call	intr_enable@PLT
	.loc 1 72 0
	call	init_ata@PLT
	.loc 1 73 0
	subl	$8, %esp
	leal	.LC12@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 75 0
	call	init_filesystem@PLT
	.loc 1 77 0
	subl	$12, %esp
	leal	.LC13@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 81 0
	call	refreshScreen@PLT
	.loc 1 83 0
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	main_init, .-main_init
	.section	.rodata
.LC14:
	.string	"SSUOS main start!!!!\n"
	.align 4
.LC15:
	.string	"          ______    ______   __    __         ______    ______  \n"
	.align 4
.LC16:
	.string	"         /      \\  /      \\ /  |  /  |       /      \\  /      \\ \n"
	.align 4
.LC17:
	.string	"        /$$$$$$  |/$$$$$$  |$$ |  $$ |      /$$$$$$  |/$$$$$$  |\n"
	.align 4
.LC18:
	.string	"        $$ \\__$$/ $$ \\__$$/ $$ |  $$ |      $$ |  $$ |$$ \\__$$/ \n"
	.align 4
.LC19:
	.string	"        $$      \\ $$      \\ $$ |  $$ |      $$ |  $$ |$$      \\ \n"
	.align 4
.LC20:
	.string	"         $$$$$$  | $$$$$$  |$$ |  $$ |      $$ |  $$ | $$$$$$  |\n"
	.align 4
.LC21:
	.string	"        /  \\__$$ |/  \\__$$ |$$ \\__$$ |      $$ \\__$$ |/  \\__$$ |\n"
	.align 4
.LC22:
	.string	"        $$    $$/ $$    $$/ $$    $$/       $$    $$/ $$    $$/ \n"
	.align 4
.LC23:
	.string	"         $$$$$$/   $$$$$$/   $$$$$$/         $$$$$$/   $$$$$$/  \n"
.LC24:
	.string	"\n"
	.align 4
.LC25:
	.string	"****************Made by OSLAB in SoongSil University*********************\n"
	.align 4
.LC26:
	.string	"contributors : Yunkyu Lee  , Minwoo Jang  , Sanghun Choi , Eunseok Choi\n"
	.align 4
.LC27:
	.string	"               Hyunho Ji   , Giwook Kang  , Kisu Kim     , Seonguk Lee \n"
	.align 4
.LC28:
	.string	"               Gibeom Byeon, Jeonghwan Lee, Kyoungmin Kim, Myungjoon Shon\n"
	.align 4
.LC29:
	.string	"               Hansol Lee  , Jinwoo Lee   , Mhanwoo Heo, Yongmin Kim, Jeongwoo Choi\n"
	.align 4
.LC30:
	.string	"************************  Professor. Jiman Hong  ************************\n"
	.align 4
.LC31:
	.string	"                                                                  \n"
	.text
	.globl	print_contributors
	.type	print_contributors, @function
print_contributors:
.LFB5:
	.loc 1 86 0
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$4, %esp
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 87 0
	subl	$8, %esp
	leal	.LC14@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 88 0
	subl	$12, %esp
	leal	.LC15@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 89 0
	subl	$12, %esp
	leal	.LC16@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 90 0
	subl	$12, %esp
	leal	.LC17@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 91 0
	subl	$12, %esp
	leal	.LC18@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 92 0
	subl	$12, %esp
	leal	.LC19@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 93 0
	subl	$12, %esp
	leal	.LC20@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 94 0
	subl	$12, %esp
	leal	.LC21@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 95 0
	subl	$12, %esp
	leal	.LC22@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 96 0
	subl	$12, %esp
	leal	.LC23@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 97 0
	subl	$12, %esp
	leal	.LC24@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 98 0
	subl	$12, %esp
	leal	.LC25@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 99 0
	subl	$12, %esp
	leal	.LC24@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 100 0
	subl	$12, %esp
	leal	.LC26@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 101 0
	subl	$12, %esp
	leal	.LC27@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 102 0
	subl	$12, %esp
	leal	.LC28@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 103 0
	subl	$12, %esp
	leal	.LC29@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 104 0
	subl	$12, %esp
	leal	.LC24@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 105 0
	subl	$12, %esp
	leal	.LC30@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 106 0
	subl	$12, %esp
	leal	.LC31@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 107 0
	nop
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	print_contributors, .-print_contributors
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB6:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE6:
	.text
.Letext0:
	.file 2 "./include/type.h"
	.file 3 "./include/device/console.h"
	.file 4 "./include/device/block.h"
	.file 5 "./include/list.h"
	.file 6 "./include/synch.h"
	.file 7 "./include/proc/proc.h"
	.file 8 "./include/filesys/fs.h"
	.file 9 "./include/filesys/inode.h"
	.file 10 "./include/filesys/file.h"
	.file 11 "./include/syscall.h"
	.file 12 "./include/device/ata.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x665
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF106
	.byte	0xc
	.long	.LASF107
	.long	.LASF108
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF1
	.uleb128 0x3
	.long	0x2c
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x5
	.long	.LASF6
	.byte	0x2
	.byte	0x2d
	.long	0x25
	.uleb128 0x5
	.long	.LASF7
	.byte	0x2
	.byte	0x30
	.long	0x71
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF8
	.uleb128 0x5
	.long	.LASF9
	.byte	0x2
	.byte	0x33
	.long	0x38
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF10
	.uleb128 0x6
	.byte	0x4
	.uleb128 0x7
	.long	.LASF11
	.byte	0x3
	.byte	0xc
	.long	0x54
	.uleb128 0x5
	.byte	0x3
	.long	Glob_x
	.uleb128 0x7
	.long	.LASF12
	.byte	0x3
	.byte	0xd
	.long	0x54
	.uleb128 0x5
	.byte	0x3
	.long	Glob_y
	.uleb128 0x5
	.long	.LASF13
	.byte	0x4
	.byte	0x12
	.long	0x78
	.uleb128 0x5
	.long	.LASF14
	.byte	0x4
	.byte	0x15
	.long	0x78
	.uleb128 0x5
	.long	.LASF15
	.byte	0x4
	.byte	0x18
	.long	0x78
	.uleb128 0x5
	.long	.LASF16
	.byte	0x4
	.byte	0x1b
	.long	0x78
	.uleb128 0x8
	.long	.LASF21
	.byte	0x14
	.byte	0x4
	.byte	0x1e
	.long	0x123
	.uleb128 0x9
	.long	.LASF17
	.byte	0x4
	.byte	0x20
	.long	0xcf
	.byte	0
	.uleb128 0x9
	.long	.LASF18
	.byte	0x4
	.byte	0x21
	.long	0xb9
	.byte	0x4
	.uleb128 0x9
	.long	.LASF19
	.byte	0x4
	.byte	0x22
	.long	0xc4
	.byte	0x8
	.uleb128 0xa
	.string	"ops"
	.byte	0x4
	.byte	0x23
	.long	0x14d
	.byte	0xc
	.uleb128 0x9
	.long	.LASF20
	.byte	0x4
	.byte	0x24
	.long	0x8a
	.byte	0x10
	.byte	0
	.uleb128 0x8
	.long	.LASF22
	.byte	0x8
	.byte	0x4
	.byte	0x2b
	.long	0x148
	.uleb128 0x9
	.long	.LASF23
	.byte	0x4
	.byte	0x2d
	.long	0x168
	.byte	0
	.uleb128 0x9
	.long	.LASF24
	.byte	0x4
	.byte	0x2e
	.long	0x18a
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.long	0x123
	.uleb128 0xb
	.byte	0x4
	.long	0x148
	.uleb128 0xc
	.long	0x168
	.uleb128 0xd
	.long	0x8a
	.uleb128 0xd
	.long	0xae
	.uleb128 0xd
	.long	0x8a
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x153
	.uleb128 0xc
	.long	0x183
	.uleb128 0xd
	.long	0x8a
	.uleb128 0xd
	.long	0xae
	.uleb128 0xd
	.long	0x183
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x189
	.uleb128 0xe
	.uleb128 0xb
	.byte	0x4
	.long	0x16e
	.uleb128 0x7
	.long	.LASF25
	.byte	0x4
	.byte	0x31
	.long	0xda
	.uleb128 0x5
	.byte	0x3
	.long	ata0_blk_dev
	.uleb128 0x7
	.long	.LASF26
	.byte	0x4
	.byte	0x32
	.long	0xda
	.uleb128 0x5
	.byte	0x3
	.long	ata1_blk_dev
	.uleb128 0x8
	.long	.LASF27
	.byte	0x8
	.byte	0x5
	.byte	0x59
	.long	0x1d7
	.uleb128 0x9
	.long	.LASF28
	.byte	0x5
	.byte	0x5b
	.long	0x1d7
	.byte	0
	.uleb128 0x9
	.long	.LASF29
	.byte	0x5
	.byte	0x5c
	.long	0x1d7
	.byte	0x4
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x1b2
	.uleb128 0x8
	.long	.LASF30
	.byte	0x10
	.byte	0x5
	.byte	0x60
	.long	0x202
	.uleb128 0x9
	.long	.LASF31
	.byte	0x5
	.byte	0x62
	.long	0x1b2
	.byte	0
	.uleb128 0x9
	.long	.LASF32
	.byte	0x5
	.byte	0x63
	.long	0x1b2
	.byte	0x8
	.byte	0
	.uleb128 0x8
	.long	.LASF33
	.byte	0x14
	.byte	0x6
	.byte	0x9
	.long	0x227
	.uleb128 0x9
	.long	.LASF34
	.byte	0x6
	.byte	0xb
	.long	0x38
	.byte	0
	.uleb128 0x9
	.long	.LASF35
	.byte	0x6
	.byte	0xc
	.long	0x1dd
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.long	.LASF36
	.byte	0x69
	.byte	0x7
	.byte	0x19
	.long	0x30b
	.uleb128 0xa
	.string	"pid"
	.byte	0x7
	.byte	0x1b
	.long	0x4c0
	.byte	0
	.uleb128 0x9
	.long	.LASF37
	.byte	0x7
	.byte	0x1c
	.long	0x8a
	.byte	0x4
	.uleb128 0xa
	.string	"pd"
	.byte	0x7
	.byte	0x1d
	.long	0x8a
	.byte	0x8
	.uleb128 0x9
	.long	.LASF38
	.byte	0x7
	.byte	0x1e
	.long	0x4cb
	.byte	0xc
	.uleb128 0x9
	.long	.LASF39
	.byte	0x7
	.byte	0x1f
	.long	0x83
	.byte	0x10
	.uleb128 0x9
	.long	.LASF40
	.byte	0x7
	.byte	0x21
	.long	0x25
	.byte	0x18
	.uleb128 0x9
	.long	.LASF41
	.byte	0x7
	.byte	0x22
	.long	0x38
	.byte	0x19
	.uleb128 0x9
	.long	.LASF42
	.byte	0x7
	.byte	0x24
	.long	0x1b2
	.byte	0x1d
	.uleb128 0x9
	.long	.LASF43
	.byte	0x7
	.byte	0x25
	.long	0x1b2
	.byte	0x25
	.uleb128 0x9
	.long	.LASF44
	.byte	0x7
	.byte	0x27
	.long	0x83
	.byte	0x2d
	.uleb128 0x9
	.long	.LASF45
	.byte	0x7
	.byte	0x28
	.long	0x83
	.byte	0x35
	.uleb128 0x9
	.long	.LASF46
	.byte	0x7
	.byte	0x29
	.long	0x30b
	.byte	0x3d
	.uleb128 0x9
	.long	.LASF47
	.byte	0x7
	.byte	0x2a
	.long	0x54
	.byte	0x41
	.uleb128 0x9
	.long	.LASF48
	.byte	0x7
	.byte	0x2b
	.long	0x54
	.byte	0x45
	.uleb128 0x9
	.long	.LASF49
	.byte	0x7
	.byte	0x2c
	.long	0x54
	.byte	0x49
	.uleb128 0x9
	.long	.LASF50
	.byte	0x7
	.byte	0x2e
	.long	0x4ba
	.byte	0x4d
	.uleb128 0xa
	.string	"cwd"
	.byte	0x7
	.byte	0x2f
	.long	0x4ba
	.byte	0x51
	.uleb128 0x9
	.long	.LASF51
	.byte	0x7
	.byte	0x31
	.long	0x4fb
	.byte	0x55
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x227
	.uleb128 0x8
	.long	.LASF52
	.byte	0x20
	.byte	0x8
	.byte	0x1b
	.long	0x34e
	.uleb128 0x9
	.long	.LASF53
	.byte	0x8
	.byte	0x1c
	.long	0x78
	.byte	0
	.uleb128 0x9
	.long	.LASF54
	.byte	0x8
	.byte	0x1d
	.long	0x78
	.byte	0x4
	.uleb128 0x9
	.long	.LASF55
	.byte	0x8
	.byte	0x1e
	.long	0x34e
	.byte	0x8
	.uleb128 0x9
	.long	.LASF56
	.byte	0x8
	.byte	0x1f
	.long	0x78
	.byte	0x1c
	.byte	0
	.uleb128 0xf
	.long	0x2c
	.long	0x35e
	.uleb128 0x10
	.long	0x38
	.byte	0x13
	.byte	0
	.uleb128 0x8
	.long	.LASF57
	.byte	0x2c
	.byte	0x8
	.byte	0x23
	.long	0x39b
	.uleb128 0x9
	.long	.LASF58
	.byte	0x8
	.byte	0x24
	.long	0x311
	.byte	0
	.uleb128 0x9
	.long	.LASF59
	.byte	0x8
	.byte	0x25
	.long	0x39b
	.byte	0x20
	.uleb128 0x9
	.long	.LASF60
	.byte	0x8
	.byte	0x26
	.long	0x3a6
	.byte	0x24
	.uleb128 0x9
	.long	.LASF61
	.byte	0x8
	.byte	0x27
	.long	0x3a6
	.byte	0x28
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0xda
	.uleb128 0x11
	.long	.LASF109
	.uleb128 0xb
	.byte	0x4
	.long	0x3a1
	.uleb128 0x12
	.long	.LASF110
	.byte	0x8
	.byte	0x36
	.long	0x35e
	.uleb128 0x5
	.byte	0x3
	.long	filesys
	.uleb128 0x8
	.long	.LASF62
	.byte	0x40
	.byte	0x9
	.byte	0x15
	.long	0x436
	.uleb128 0x9
	.long	.LASF63
	.byte	0x9
	.byte	0x17
	.long	0x78
	.byte	0
	.uleb128 0x9
	.long	.LASF64
	.byte	0x9
	.byte	0x18
	.long	0x78
	.byte	0x4
	.uleb128 0x9
	.long	.LASF65
	.byte	0x9
	.byte	0x19
	.long	0x66
	.byte	0x8
	.uleb128 0x9
	.long	.LASF66
	.byte	0x9
	.byte	0x1a
	.long	0x66
	.byte	0xa
	.uleb128 0x9
	.long	.LASF67
	.byte	0x9
	.byte	0x1b
	.long	0x78
	.byte	0xc
	.uleb128 0x9
	.long	.LASF68
	.byte	0x9
	.byte	0x1c
	.long	0x436
	.byte	0x10
	.uleb128 0x9
	.long	.LASF69
	.byte	0x9
	.byte	0x1d
	.long	0x446
	.byte	0x18
	.uleb128 0x9
	.long	.LASF70
	.byte	0x9
	.byte	0x1e
	.long	0x456
	.byte	0x38
	.uleb128 0x9
	.long	.LASF71
	.byte	0x9
	.byte	0x1f
	.long	0x78
	.byte	0x3c
	.byte	0
	.uleb128 0xf
	.long	0x78
	.long	0x446
	.uleb128 0x10
	.long	0x38
	.byte	0x1
	.byte	0
	.uleb128 0xf
	.long	0x78
	.long	0x456
	.uleb128 0x10
	.long	0x38
	.byte	0x7
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x35e
	.uleb128 0xf
	.long	0x3bd
	.long	0x46c
	.uleb128 0x10
	.long	0x38
	.byte	0xff
	.byte	0
	.uleb128 0x7
	.long	.LASF72
	.byte	0x9
	.byte	0x2c
	.long	0x45c
	.uleb128 0x5
	.byte	0x3
	.long	inode_tbl
	.uleb128 0x8
	.long	.LASF73
	.byte	0x8
	.byte	0xa
	.byte	0x10
	.long	0x4ba
	.uleb128 0x9
	.long	.LASF62
	.byte	0xa
	.byte	0x11
	.long	0x4ba
	.byte	0
	.uleb128 0xa
	.string	"pos"
	.byte	0xa
	.byte	0x12
	.long	0x66
	.byte	0x4
	.uleb128 0x9
	.long	.LASF74
	.byte	0xa
	.byte	0x13
	.long	0x5b
	.byte	0x6
	.uleb128 0x9
	.long	.LASF75
	.byte	0xa
	.byte	0x14
	.long	0x5b
	.byte	0x7
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x3bd
	.uleb128 0x5
	.long	.LASF76
	.byte	0x7
	.byte	0x8
	.long	0x54
	.uleb128 0x13
	.long	.LASF83
	.byte	0x7
	.byte	0x4
	.long	0x38
	.byte	0x7
	.byte	0xa
	.long	0x4fb
	.uleb128 0x14
	.long	.LASF77
	.byte	0
	.uleb128 0x14
	.long	.LASF78
	.byte	0x1
	.uleb128 0x14
	.long	.LASF79
	.byte	0x2
	.uleb128 0x14
	.long	.LASF80
	.byte	0x3
	.uleb128 0x14
	.long	.LASF81
	.byte	0x4
	.byte	0
	.uleb128 0xf
	.long	0x50b
	.long	0x50b
	.uleb128 0x10
	.long	0x38
	.byte	0x4
	.byte	0
	.uleb128 0xb
	.byte	0x4
	.long	0x47d
	.uleb128 0x15
	.long	.LASF82
	.byte	0x7
	.byte	0x36
	.long	0x30b
	.uleb128 0x13
	.long	.LASF84
	.byte	0x7
	.byte	0x4
	.long	0x38
	.byte	0xb
	.byte	0x4
	.long	0x564
	.uleb128 0x14
	.long	.LASF85
	.byte	0
	.uleb128 0x14
	.long	.LASF86
	.byte	0x1
	.uleb128 0x14
	.long	.LASF87
	.byte	0x2
	.uleb128 0x14
	.long	.LASF88
	.byte	0x3
	.uleb128 0x14
	.long	.LASF89
	.byte	0x4
	.uleb128 0x14
	.long	.LASF90
	.byte	0x5
	.uleb128 0x14
	.long	.LASF91
	.byte	0x6
	.uleb128 0x14
	.long	.LASF92
	.byte	0x7
	.uleb128 0x14
	.long	.LASF93
	.byte	0x8
	.byte	0
	.uleb128 0xf
	.long	0x54
	.long	0x57a
	.uleb128 0x10
	.long	0x38
	.byte	0x7
	.uleb128 0x10
	.long	0x38
	.byte	0x1
	.byte	0
	.uleb128 0x15
	.long	.LASF94
	.byte	0xb
	.byte	0x1e
	.long	0x564
	.uleb128 0x8
	.long	.LASF95
	.byte	0x1c
	.byte	0xc
	.byte	0x39
	.long	0x5c2
	.uleb128 0x9
	.long	.LASF17
	.byte	0xc
	.byte	0x3b
	.long	0x5b
	.byte	0
	.uleb128 0x9
	.long	.LASF96
	.byte	0xc
	.byte	0x3c
	.long	0x66
	.byte	0x2
	.uleb128 0xa
	.string	"irq"
	.byte	0xc
	.byte	0x3d
	.long	0x5b
	.byte	0x4
	.uleb128 0x9
	.long	.LASF97
	.byte	0xc
	.byte	0x3e
	.long	0x202
	.byte	0x8
	.byte	0
	.uleb128 0x8
	.long	.LASF98
	.byte	0x38
	.byte	0xc
	.byte	0x41
	.long	0x5db
	.uleb128 0x9
	.long	.LASF99
	.byte	0xc
	.byte	0x43
	.long	0x5db
	.byte	0
	.byte	0
	.uleb128 0xf
	.long	0x585
	.long	0x5eb
	.uleb128 0x10
	.long	0x38
	.byte	0x1
	.byte	0
	.uleb128 0x16
	.string	"ata"
	.byte	0xc
	.byte	0x46
	.long	0x5c2
	.uleb128 0x5
	.byte	0x3
	.long	ata
	.uleb128 0x7
	.long	.LASF100
	.byte	0x1
	.byte	0x18
	.long	0x60d
	.uleb128 0x5
	.byte	0x3
	.long	VERSION
	.uleb128 0xb
	.byte	0x4
	.long	0x33
	.uleb128 0x7
	.long	.LASF101
	.byte	0x1
	.byte	0x19
	.long	0x60d
	.uleb128 0x5
	.byte	0x3
	.long	AUTHOR
	.uleb128 0x7
	.long	.LASF102
	.byte	0x1
	.byte	0x1a
	.long	0x60d
	.uleb128 0x5
	.byte	0x3
	.long	MODIFIER
	.uleb128 0x17
	.long	.LASF103
	.byte	0x1
	.byte	0x55
	.long	.LFB5
	.long	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x17
	.long	.LASF104
	.byte	0x1
	.byte	0x25
	.long	.LFB4
	.long	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x17
	.long	.LASF105
	.byte	0x1
	.byte	0x1c
	.long	.LFB3
	.long	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF66:
	.string	"sn_nlink"
.LASF45:
	.string	"time_sched"
.LASF106:
	.string	"GNU C11 7.3.0 -m32 -mtune=generic -march=i686 -g -O0 -ffreestanding -fno-stack-protector"
.LASF24:
	.string	"write"
.LASF40:
	.string	"priority"
.LASF49:
	.string	"exit_status"
.LASF16:
	.string	"blk_dev_t"
.LASF15:
	.string	"blk_size_t"
.LASF38:
	.string	"state"
.LASF101:
	.string	"AUTHOR"
.LASF5:
	.string	"short int"
.LASF98:
	.string	"ata_interface"
.LASF52:
	.string	"ssu_superblock"
.LASF91:
	.string	"SYS_READ"
.LASF110:
	.string	"filesys"
.LASF77:
	.string	"PROC_UNUSED"
.LASF19:
	.string	"blk_size"
.LASF33:
	.string	"semaphore"
.LASF73:
	.string	"ssufile"
.LASF25:
	.string	"ata0_blk_dev"
.LASF90:
	.string	"SYS_OPEN"
.LASF51:
	.string	"file"
.LASF93:
	.string	"SYS_NUM"
.LASF65:
	.string	"sn_type"
.LASF26:
	.string	"ata1_blk_dev"
.LASF34:
	.string	"value"
.LASF94:
	.string	"syscall_tbl"
.LASF31:
	.string	"head"
.LASF99:
	.string	"nodes"
.LASF88:
	.string	"SYS_SSUREAD"
.LASF6:
	.string	"uint8_t"
.LASF46:
	.string	"parent"
.LASF109:
	.string	"bitmap"
.LASF89:
	.string	"SYS_SHUTDOWN"
.LASF14:
	.string	"blk_cnt_t"
.LASF36:
	.string	"process"
.LASF48:
	.string	"child_pid"
.LASF23:
	.string	"read"
.LASF3:
	.string	"long long int"
.LASF70:
	.string	"sn_fs"
.LASF61:
	.string	"fs_inodemap"
.LASF63:
	.string	"sn_ino"
.LASF50:
	.string	"rootdir"
.LASF79:
	.string	"PROC_STOP"
.LASF85:
	.string	"SYS_FORK"
.LASF18:
	.string	"blk_count"
.LASF71:
	.string	"cnt_data_block"
.LASF21:
	.string	"blk_dev"
.LASF74:
	.string	"flags"
.LASF43:
	.string	"elem_stat"
.LASF32:
	.string	"tail"
.LASF0:
	.string	"unsigned char"
.LASF35:
	.string	"waiters"
.LASF44:
	.string	"time_used"
.LASF55:
	.string	"sb_volname"
.LASF107:
	.string	"arch/Main.c"
.LASF4:
	.string	"signed char"
.LASF13:
	.string	"blk_sec_t"
.LASF10:
	.string	"long long unsigned int"
.LASF9:
	.string	"uint32_t"
.LASF60:
	.string	"fs_blkmap"
.LASF2:
	.string	"unsigned int"
.LASF81:
	.string	"PROC_BLOCK"
.LASF108:
	.string	"/media/jahn/External2/os/p8/ssuos/src/kernel"
.LASF37:
	.string	"stack"
.LASF27:
	.string	"list_elem"
.LASF92:
	.string	"SYS_WRITE"
.LASF105:
	.string	"ssuos_main"
.LASF53:
	.string	"sb_magic"
.LASF64:
	.string	"sn_size"
.LASF8:
	.string	"short unsigned int"
.LASF62:
	.string	"inode"
.LASF22:
	.string	"blk_dev_ops"
.LASF1:
	.string	"char"
.LASF7:
	.string	"uint16_t"
.LASF17:
	.string	"type"
.LASF83:
	.string	"p_state"
.LASF30:
	.string	"list"
.LASF42:
	.string	"elem_all"
.LASF103:
	.string	"print_contributors"
.LASF67:
	.string	"sn_refcount"
.LASF72:
	.string	"inode_tbl"
.LASF41:
	.string	"time_slice"
.LASF100:
	.string	"VERSION"
.LASF57:
	.string	"ssu_fs"
.LASF102:
	.string	"MODIFIER"
.LASF56:
	.string	"padding"
.LASF80:
	.string	"PROC_ZOMBIE"
.LASF39:
	.string	"time_sleep"
.LASF78:
	.string	"PROC_RUN"
.LASF86:
	.string	"SYS_EXIT"
.LASF97:
	.string	"sema"
.LASF76:
	.string	"pid_t"
.LASF75:
	.string	"unused"
.LASF87:
	.string	"SYS_WAIT"
.LASF68:
	.string	"sn_directblock"
.LASF95:
	.string	"ata_device"
.LASF54:
	.string	"sb_nblocks"
.LASF69:
	.string	"sn_indirectblock"
.LASF47:
	.string	"simple_lock"
.LASF59:
	.string	"fs_device"
.LASF82:
	.string	"cur_process"
.LASF104:
	.string	"main_init"
.LASF20:
	.string	"device_info"
.LASF96:
	.string	"port_addr"
.LASF58:
	.string	"fs_sb"
.LASF28:
	.string	"prev"
.LASF11:
	.string	"Glob_x"
.LASF12:
	.string	"Glob_y"
.LASF84:
	.string	"SYS_LIST"
.LASF29:
	.string	"next"
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
