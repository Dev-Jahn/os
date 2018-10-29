	.file	"Main.c"
	.text
.Ltext0:
	.comm	Glob_x,4,4
	.comm	Glob_y,4,4
	.globl	VERSION
	.section	.rodata
.LC0:
	.string	"0.1.03"
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
	.loc 1 27 0
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
	.loc 1 28 0
	call	main_init
	.loc 1 30 0
	subl	$12, %esp
	pushl	$0
	call	idle@PLT
	addl	$16, %esp
	.loc 1 32 0
	nop
	.loc 1 33 0
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
	.string	"Memory Detecting\n"
.LC4:
	.string	"%s"
.LC5:
	.string	"-Memory size = %u Kbytes\n"
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
	.align 4
.LC12:
	.string	"========== initialization complete ==========\n\n"
	.text
	.globl	main_init
	.type	main_init, @function
main_init:
.LFB4:
	.loc 1 36 0
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
	.loc 1 37 0
	call	intr_disable@PLT
	.loc 1 40 0
	call	init_console@PLT
	.loc 1 42 0
	call	print_contributors
	.loc 1 44 0
	call	detect_mem@PLT
	.loc 1 45 0
	subl	$8, %esp
	leal	.LC3@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 46 0
	call	mem_size@PLT
	shrl	$10, %eax
	subl	$8, %esp
	pushl	%eax
	leal	.LC5@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 48 0
	call	init_pit@PLT
	.loc 1 49 0
	subl	$8, %esp
	leal	.LC6@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 51 0
	call	init_syscall@PLT
	.loc 1 52 0
	subl	$8, %esp
	leal	.LC7@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 54 0
	call	init_intr@PLT
	.loc 1 55 0
	subl	$8, %esp
	leal	.LC8@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 57 0
	call	init_kbd@PLT
	.loc 1 59 0
	call	init_palloc@PLT
	.loc 1 60 0
	subl	$12, %esp
	leal	.LC9@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 62 0
	call	init_paging@PLT
	.loc 1 63 0
	subl	$8, %esp
	leal	.LC10@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 65 0
	call	init_proc@PLT
	.loc 1 66 0
	subl	$8, %esp
	leal	.LC11@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 68 0
	call	intr_enable@PLT
	.loc 1 70 0
	call	palloc_pf_test@PLT
	.loc 1 72 0
	call	refreshScreen@PLT
	.loc 1 75 0
	call	sema_self_test@PLT
	.loc 1 76 0
	subl	$12, %esp
	leal	.LC12@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 80 0
	call	refreshScreen@PLT
	.loc 1 82 0
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
.LC13:
	.string	"SSUOS main start!!!!\n"
	.align 4
.LC14:
	.string	"          ______    ______   __    __         ______    ______  \n"
	.align 4
.LC15:
	.string	"         /      \\  /      \\ /  |  /  |       /      \\  /      \\ \n"
	.align 4
.LC16:
	.string	"        /$$$$$$  |/$$$$$$  |$$ |  $$ |      /$$$$$$  |/$$$$$$  |\n"
	.align 4
.LC17:
	.string	"        $$ \\__$$/ $$ \\__$$/ $$ |  $$ |      $$ |  $$ |$$ \\__$$/ \n"
	.align 4
.LC18:
	.string	"        $$      \\ $$      \\ $$ |  $$ |      $$ |  $$ |$$      \\ \n"
	.align 4
.LC19:
	.string	"         $$$$$$  | $$$$$$  |$$ |  $$ |      $$ |  $$ | $$$$$$  |\n"
	.align 4
.LC20:
	.string	"        /  \\__$$ |/  \\__$$ |$$ \\__$$ |      $$ \\__$$ |/  \\__$$ |\n"
	.align 4
.LC21:
	.string	"        $$    $$/ $$    $$/ $$    $$/       $$    $$/ $$    $$/ \n"
	.align 4
.LC22:
	.string	"         $$$$$$/   $$$$$$/   $$$$$$/         $$$$$$/   $$$$$$/  \n"
.LC23:
	.string	"\n"
	.align 4
.LC24:
	.string	"****************Made by OSLAB in SoongSil University*********************\n"
	.align 4
.LC25:
	.string	"contributors : Yunkyu Lee  , Minwoo Jang  , Sanghun Choi , Eunseok Choi\n"
	.align 4
.LC26:
	.string	"               Hyunho Ji   , Giwook Kang  , Kisu Kim     , Seonguk Lee \n"
	.align 4
.LC27:
	.string	"               Gibeom Byeon, Jeonghwan Lee, Kyoungmin Kim, Myungjoon Shon\n"
	.align 4
.LC28:
	.string	"               Jinwoo Lee  , Hansol Lee   , Mhanwoo Heo, Jeongwoo Choi\n"
.LC29:
	.string	"               Yongmin Kim\n"
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
	.loc 1 85 0
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
	.loc 1 86 0
	subl	$8, %esp
	leal	.LC13@GOTOFF(%ebx), %eax
	pushl	%eax
	leal	.LC4@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 87 0
	subl	$12, %esp
	leal	.LC14@GOTOFF(%ebx), %eax
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
	leal	.LC23@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printk@PLT
	addl	$16, %esp
	.loc 1 99 0
	subl	$12, %esp
	leal	.LC25@GOTOFF(%ebx), %eax
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
	leal	.LC23@GOTOFF(%ebx), %eax
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
	.file 2 "./include/device/console.h"
	.file 3 "./include/list.h"
	.file 4 "./include/proc/proc.h"
	.file 5 "./include/syscall.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x284
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF48
	.byte	0xc
	.long	.LASF49
	.long	.LASF50
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
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF6
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF7
	.uleb128 0x5
	.byte	0x4
	.uleb128 0x6
	.long	.LASF8
	.byte	0x2
	.byte	0xc
	.long	0x54
	.uleb128 0x5
	.byte	0x3
	.long	Glob_x
	.uleb128 0x6
	.long	.LASF9
	.byte	0x2
	.byte	0xd
	.long	0x54
	.uleb128 0x5
	.byte	0x3
	.long	Glob_y
	.uleb128 0x7
	.long	.LASF17
	.byte	0x8
	.byte	0x3
	.byte	0x59
	.long	0xb2
	.uleb128 0x8
	.long	.LASF10
	.byte	0x3
	.byte	0x5b
	.long	0xb2
	.byte	0
	.uleb128 0x8
	.long	.LASF11
	.byte	0x3
	.byte	0x5c
	.long	0xb2
	.byte	0x4
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.long	0x8d
	.uleb128 0xa
	.long	.LASF51
	.byte	0x4
	.byte	0x6
	.long	0x54
	.uleb128 0xb
	.long	.LASF33
	.byte	0x7
	.byte	0x4
	.long	0x38
	.byte	0x4
	.byte	0x8
	.long	0xf3
	.uleb128 0xc
	.long	.LASF12
	.byte	0
	.uleb128 0xc
	.long	.LASF13
	.byte	0x1
	.uleb128 0xc
	.long	.LASF14
	.byte	0x2
	.uleb128 0xc
	.long	.LASF15
	.byte	0x3
	.uleb128 0xc
	.long	.LASF16
	.byte	0x4
	.byte	0
	.uleb128 0x7
	.long	.LASF18
	.byte	0x4d
	.byte	0x4
	.byte	0x17
	.long	0x1b3
	.uleb128 0xd
	.string	"pid"
	.byte	0x4
	.byte	0x19
	.long	0xb8
	.byte	0
	.uleb128 0x8
	.long	.LASF19
	.byte	0x4
	.byte	0x1a
	.long	0x69
	.byte	0x4
	.uleb128 0xd
	.string	"pd"
	.byte	0x4
	.byte	0x1b
	.long	0x69
	.byte	0x8
	.uleb128 0x8
	.long	.LASF20
	.byte	0x4
	.byte	0x1c
	.long	0xc3
	.byte	0xc
	.uleb128 0x8
	.long	.LASF21
	.byte	0x4
	.byte	0x1d
	.long	0x62
	.byte	0x10
	.uleb128 0x8
	.long	.LASF22
	.byte	0x4
	.byte	0x1f
	.long	0x25
	.byte	0x18
	.uleb128 0x8
	.long	.LASF23
	.byte	0x4
	.byte	0x20
	.long	0x38
	.byte	0x19
	.uleb128 0x8
	.long	.LASF24
	.byte	0x4
	.byte	0x22
	.long	0x8d
	.byte	0x1d
	.uleb128 0x8
	.long	.LASF25
	.byte	0x4
	.byte	0x23
	.long	0x8d
	.byte	0x25
	.uleb128 0x8
	.long	.LASF26
	.byte	0x4
	.byte	0x25
	.long	0x62
	.byte	0x2d
	.uleb128 0x8
	.long	.LASF27
	.byte	0x4
	.byte	0x26
	.long	0x62
	.byte	0x35
	.uleb128 0x8
	.long	.LASF28
	.byte	0x4
	.byte	0x27
	.long	0x1b3
	.byte	0x3d
	.uleb128 0x8
	.long	.LASF29
	.byte	0x4
	.byte	0x28
	.long	0x54
	.byte	0x41
	.uleb128 0x8
	.long	.LASF30
	.byte	0x4
	.byte	0x29
	.long	0x54
	.byte	0x45
	.uleb128 0x8
	.long	.LASF31
	.byte	0x4
	.byte	0x2a
	.long	0x54
	.byte	0x49
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.long	0xf3
	.uleb128 0xe
	.long	.LASF32
	.byte	0x4
	.byte	0x2f
	.long	0x1b3
	.uleb128 0xb
	.long	.LASF34
	.byte	0x7
	.byte	0x4
	.long	0x38
	.byte	0x5
	.byte	0x4
	.long	0x1fa
	.uleb128 0xc
	.long	.LASF35
	.byte	0
	.uleb128 0xc
	.long	.LASF36
	.byte	0x1
	.uleb128 0xc
	.long	.LASF37
	.byte	0x2
	.uleb128 0xc
	.long	.LASF38
	.byte	0x3
	.uleb128 0xc
	.long	.LASF39
	.byte	0x4
	.uleb128 0xc
	.long	.LASF40
	.byte	0x5
	.byte	0
	.uleb128 0xf
	.long	0x54
	.long	0x210
	.uleb128 0x10
	.long	0x38
	.byte	0x4
	.uleb128 0x10
	.long	0x38
	.byte	0x1
	.byte	0
	.uleb128 0xe
	.long	.LASF41
	.byte	0x5
	.byte	0x16
	.long	0x1fa
	.uleb128 0x6
	.long	.LASF42
	.byte	0x1
	.byte	0x16
	.long	0x22c
	.uleb128 0x5
	.byte	0x3
	.long	VERSION
	.uleb128 0x9
	.byte	0x4
	.long	0x33
	.uleb128 0x6
	.long	.LASF43
	.byte	0x1
	.byte	0x17
	.long	0x22c
	.uleb128 0x5
	.byte	0x3
	.long	AUTHOR
	.uleb128 0x6
	.long	.LASF44
	.byte	0x1
	.byte	0x18
	.long	0x22c
	.uleb128 0x5
	.byte	0x3
	.long	MODIFIER
	.uleb128 0x11
	.long	.LASF45
	.byte	0x1
	.byte	0x54
	.long	.LFB5
	.long	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x11
	.long	.LASF46
	.byte	0x1
	.byte	0x23
	.long	.LFB4
	.long	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x11
	.long	.LASF47
	.byte	0x1
	.byte	0x1a
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
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
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
	.uleb128 0xe
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
.LASF27:
	.string	"time_sched"
.LASF48:
	.string	"GNU C11 7.3.0 -m32 -mtune=generic -march=i686 -g -O0 -ffreestanding -fno-stack-protector"
.LASF22:
	.string	"priority"
.LASF31:
	.string	"exit_status"
.LASF37:
	.string	"SYS_WAIT"
.LASF20:
	.string	"state"
.LASF5:
	.string	"short int"
.LASF40:
	.string	"SYS_NUM"
.LASF12:
	.string	"PROC_UNUSED"
.LASF41:
	.string	"syscall_tbl"
.LASF38:
	.string	"SYS_SSUREAD"
.LASF28:
	.string	"parent"
.LASF39:
	.string	"SYS_SHUTDOWN"
.LASF45:
	.string	"print_contributors"
.LASF18:
	.string	"process"
.LASF30:
	.string	"child_pid"
.LASF3:
	.string	"long long int"
.LASF46:
	.string	"main_init"
.LASF43:
	.string	"AUTHOR"
.LASF35:
	.string	"SYS_FORK"
.LASF25:
	.string	"elem_stat"
.LASF0:
	.string	"unsigned char"
.LASF26:
	.string	"time_used"
.LASF49:
	.string	"arch/Main.c"
.LASF4:
	.string	"signed char"
.LASF47:
	.string	"ssuos_main"
.LASF7:
	.string	"long long unsigned int"
.LASF2:
	.string	"unsigned int"
.LASF16:
	.string	"PROC_BLOCK"
.LASF19:
	.string	"stack"
.LASF17:
	.string	"list_elem"
.LASF14:
	.string	"PROC_STOP"
.LASF6:
	.string	"short unsigned int"
.LASF1:
	.string	"char"
.LASF33:
	.string	"p_state"
.LASF24:
	.string	"elem_all"
.LASF23:
	.string	"time_slice"
.LASF42:
	.string	"VERSION"
.LASF50:
	.string	"/media/jahn/External2/os/p5/ssuos/src/kernel"
.LASF44:
	.string	"MODIFIER"
.LASF21:
	.string	"time_sleep"
.LASF13:
	.string	"PROC_RUN"
.LASF36:
	.string	"SYS_EXIT"
.LASF51:
	.string	"pid_t"
.LASF29:
	.string	"simple_lock"
.LASF32:
	.string	"cur_process"
.LASF15:
	.string	"PROC_ZOMBIE"
.LASF10:
	.string	"prev"
.LASF8:
	.string	"Glob_x"
.LASF9:
	.string	"Glob_y"
.LASF34:
	.string	"SYS_LIST"
.LASF11:
	.string	"next"
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
