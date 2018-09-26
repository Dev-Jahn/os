	.file	"Main.c"
	.text
.Ltext0:
	.globl	VERSION
	.section	.rodata
.LC0:
	.string	"0.1.02"
	.data
	.align 4
	.type	VERSION, @object
	.size	VERSION, 4
VERSION:
	.long	.LC0
	.globl	AUTHOR
	.section	.rodata
.LC1:
	.string	"OSLAB"
	.data
	.align 4
	.type	AUTHOR, @object
	.size	AUTHOR, 4
AUTHOR:
	.long	.LC1
	.globl	MODIFIER
	.section	.rodata
.LC2:
	.string	"You"
	.data
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
	.loc 1 28 0
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 29 0
	call	main_init
	.loc 1 31 0
	subl	$12, %esp
	pushl	$0
	call	idle
	addl	$16, %esp
	.loc 1 33 0
	nop
	.loc 1 34 0
	leave
	.cfi_restore 5
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
	.loc 1 37 0
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 38 0
	call	intr_disable
	.loc 1 41 0
	call	get_console
	movl	%eax, cur_console
	.loc 1 42 0
	call	init_console
	.loc 1 44 0
	call	print_contributors
	.loc 1 46 0
	call	detect_mem
	.loc 1 47 0
	subl	$8, %esp
	pushl	$.LC3
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 48 0
	call	mem_size
	shrl	$10, %eax
	subl	$8, %esp
	pushl	%eax
	pushl	$.LC5
	call	printk
	addl	$16, %esp
	.loc 1 50 0
	call	init_pit
	.loc 1 51 0
	subl	$8, %esp
	pushl	$.LC6
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 53 0
	call	init_syscall
	.loc 1 54 0
	subl	$8, %esp
	pushl	$.LC7
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 56 0
	call	init_intr
	.loc 1 57 0
	subl	$8, %esp
	pushl	$.LC8
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 59 0
	call	init_palloc
	.loc 1 60 0
	subl	$12, %esp
	pushl	$.LC9
	call	printk
	addl	$16, %esp
	.loc 1 62 0
	call	init_paging
	.loc 1 63 0
	subl	$8, %esp
	pushl	$.LC10
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 65 0
	call	init_proc
	.loc 1 66 0
	subl	$8, %esp
	pushl	$.LC11
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 68 0
	movl	cur_process, %eax
	movl	cur_console, %edx
	movl	%edx, 77(%eax)
	.loc 1 73 0
	call	intr_enable
	.loc 1 79 0
	call	sema_self_test
	.loc 1 80 0
	subl	$12, %esp
	pushl	$.LC12
	call	printk
	addl	$16, %esp
	.loc 1 84 0
	call	refreshScreen
	.loc 1 86 0
	nop
	leave
	.cfi_restore 5
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
	.string	"               Hansol Lee  , Jinwoo Lee   , Mhanwoo Heo\n"
	.align 4
.LC29:
	.string	"************************  Professor. Jiman Hong  ************************\n"
	.align 4
.LC30:
	.string	"                                                                  \n"
	.text
	.globl	print_contributors
	.type	print_contributors, @function
print_contributors:
.LFB5:
	.loc 1 89 0
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	.loc 1 90 0
	subl	$8, %esp
	pushl	$.LC13
	pushl	$.LC4
	call	printk
	addl	$16, %esp
	.loc 1 91 0
	subl	$12, %esp
	pushl	$.LC14
	call	printk
	addl	$16, %esp
	.loc 1 92 0
	subl	$12, %esp
	pushl	$.LC15
	call	printk
	addl	$16, %esp
	.loc 1 93 0
	subl	$12, %esp
	pushl	$.LC16
	call	printk
	addl	$16, %esp
	.loc 1 94 0
	subl	$12, %esp
	pushl	$.LC17
	call	printk
	addl	$16, %esp
	.loc 1 95 0
	subl	$12, %esp
	pushl	$.LC18
	call	printk
	addl	$16, %esp
	.loc 1 96 0
	subl	$12, %esp
	pushl	$.LC19
	call	printk
	addl	$16, %esp
	.loc 1 97 0
	subl	$12, %esp
	pushl	$.LC20
	call	printk
	addl	$16, %esp
	.loc 1 98 0
	subl	$12, %esp
	pushl	$.LC21
	call	printk
	addl	$16, %esp
	.loc 1 99 0
	subl	$12, %esp
	pushl	$.LC22
	call	printk
	addl	$16, %esp
	.loc 1 100 0
	subl	$12, %esp
	pushl	$.LC23
	call	printk
	addl	$16, %esp
	.loc 1 101 0
	subl	$12, %esp
	pushl	$.LC24
	call	printk
	addl	$16, %esp
	.loc 1 102 0
	subl	$12, %esp
	pushl	$.LC23
	call	printk
	addl	$16, %esp
	.loc 1 103 0
	subl	$12, %esp
	pushl	$.LC25
	call	printk
	addl	$16, %esp
	.loc 1 104 0
	subl	$12, %esp
	pushl	$.LC26
	call	printk
	addl	$16, %esp
	.loc 1 105 0
	subl	$12, %esp
	pushl	$.LC27
	call	printk
	addl	$16, %esp
	.loc 1 106 0
	subl	$12, %esp
	pushl	$.LC28
	call	printk
	addl	$16, %esp
	.loc 1 107 0
	subl	$12, %esp
	pushl	$.LC23
	call	printk
	addl	$16, %esp
	.loc 1 108 0
	subl	$12, %esp
	pushl	$.LC29
	call	printk
	addl	$16, %esp
	.loc 1 109 0
	subl	$12, %esp
	pushl	$.LC30
	call	printk
	addl	$16, %esp
	.loc 1 110 0
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	print_contributors, .-print_contributors
.Letext0:
	.file 2 "./include/type.h"
	.file 3 "./include/device/console.h"
	.file 4 "./include/device/kbd.h"
	.file 5 "./include/list.h"
	.file 6 "./include/proc/proc.h"
	.file 7 "./include/syscall.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x373
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF64
	.byte	0xc
	.long	.LASF65
	.long	.LASF66
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF0
	.uleb128 0x3
	.long	.LASF2
	.byte	0x2
	.byte	0x6
	.long	0x37
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF1
	.uleb128 0x3
	.long	.LASF3
	.byte	0x2
	.byte	0x8
	.long	0x37
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF4
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF5
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF9
	.uleb128 0x5
	.byte	0x4
	.uleb128 0x6
	.long	.LASF18
	.value	0x1f58
	.byte	0x3
	.byte	0x26
	.long	0xef
	.uleb128 0x7
	.long	.LASF10
	.byte	0x3
	.byte	0x27
	.long	0x65
	.byte	0
	.uleb128 0x7
	.long	.LASF11
	.byte	0x3
	.byte	0x28
	.long	0x65
	.byte	0x4
	.uleb128 0x7
	.long	.LASF12
	.byte	0x3
	.byte	0x2a
	.long	0xef
	.byte	0x8
	.uleb128 0x8
	.long	.LASF13
	.byte	0x3
	.byte	0x2b
	.long	0x107
	.value	0x1f48
	.uleb128 0x8
	.long	.LASF14
	.byte	0x3
	.byte	0x2c
	.long	0x107
	.value	0x1f4c
	.uleb128 0x8
	.long	.LASF15
	.byte	0x3
	.byte	0x2d
	.long	0x65
	.value	0x1f50
	.uleb128 0x9
	.string	"a_s"
	.byte	0x3
	.byte	0x2e
	.long	0x3e
	.value	0x1f54
	.uleb128 0x8
	.long	.LASF16
	.byte	0x3
	.byte	0x30
	.long	0x3e
	.value	0x1f55
	.byte	0
	.uleb128 0xa
	.long	0x37
	.long	0x100
	.uleb128 0xb
	.long	0x100
	.value	0x1f3f
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF17
	.uleb128 0xc
	.byte	0x4
	.long	0x37
	.uleb128 0x6
	.long	.LASF19
	.value	0x20c
	.byte	0x4
	.byte	0x2d
	.long	0x14e
	.uleb128 0xd
	.string	"buf"
	.byte	0x4
	.byte	0x2e
	.long	0x14e
	.byte	0
	.uleb128 0x8
	.long	.LASF20
	.byte	0x4
	.byte	0x2f
	.long	0x65
	.value	0x200
	.uleb128 0x8
	.long	.LASF21
	.byte	0x4
	.byte	0x30
	.long	0x65
	.value	0x204
	.uleb128 0x8
	.long	.LASF16
	.byte	0x4
	.byte	0x31
	.long	0x2c
	.value	0x208
	.byte	0
	.uleb128 0xa
	.long	0x37
	.long	0x15f
	.uleb128 0xb
	.long	0x100
	.value	0x1ff
	.byte	0
	.uleb128 0xe
	.long	.LASF22
	.byte	0x8
	.byte	0x5
	.byte	0x59
	.long	0x184
	.uleb128 0x7
	.long	.LASF23
	.byte	0x5
	.byte	0x5b
	.long	0x184
	.byte	0
	.uleb128 0x7
	.long	.LASF24
	.byte	0x5
	.byte	0x5c
	.long	0x184
	.byte	0x4
	.byte	0
	.uleb128 0xc
	.byte	0x4
	.long	0x15f
	.uleb128 0x3
	.long	.LASF25
	.byte	0x6
	.byte	0x8
	.long	0x65
	.uleb128 0xf
	.long	.LASF48
	.byte	0x4
	.long	0x49
	.byte	0x6
	.byte	0xa
	.long	0x1c4
	.uleb128 0x10
	.long	.LASF26
	.byte	0
	.uleb128 0x10
	.long	.LASF27
	.byte	0x1
	.uleb128 0x10
	.long	.LASF28
	.byte	0x2
	.uleb128 0x10
	.long	.LASF29
	.byte	0x3
	.uleb128 0x10
	.long	.LASF30
	.byte	0x4
	.byte	0
	.uleb128 0xe
	.long	.LASF31
	.byte	0x5d
	.byte	0x6
	.byte	0x1a
	.long	0x2a8
	.uleb128 0xd
	.string	"pid"
	.byte	0x6
	.byte	0x1c
	.long	0x18a
	.byte	0
	.uleb128 0x7
	.long	.LASF32
	.byte	0x6
	.byte	0x1d
	.long	0x7a
	.byte	0x4
	.uleb128 0xd
	.string	"pd"
	.byte	0x6
	.byte	0x1e
	.long	0x7a
	.byte	0x8
	.uleb128 0x7
	.long	.LASF33
	.byte	0x6
	.byte	0x1f
	.long	0x195
	.byte	0xc
	.uleb128 0x7
	.long	.LASF34
	.byte	0x6
	.byte	0x20
	.long	0x73
	.byte	0x10
	.uleb128 0x7
	.long	.LASF35
	.byte	0x6
	.byte	0x22
	.long	0x25
	.byte	0x18
	.uleb128 0x7
	.long	.LASF36
	.byte	0x6
	.byte	0x23
	.long	0x49
	.byte	0x19
	.uleb128 0x7
	.long	.LASF37
	.byte	0x6
	.byte	0x25
	.long	0x15f
	.byte	0x1d
	.uleb128 0x7
	.long	.LASF38
	.byte	0x6
	.byte	0x26
	.long	0x15f
	.byte	0x25
	.uleb128 0x7
	.long	.LASF39
	.byte	0x6
	.byte	0x27
	.long	0x15f
	.byte	0x2d
	.uleb128 0x7
	.long	.LASF40
	.byte	0x6
	.byte	0x29
	.long	0x73
	.byte	0x35
	.uleb128 0x7
	.long	.LASF41
	.byte	0x6
	.byte	0x2a
	.long	0x73
	.byte	0x3d
	.uleb128 0x7
	.long	.LASF42
	.byte	0x6
	.byte	0x2b
	.long	0x2a8
	.byte	0x45
	.uleb128 0x7
	.long	.LASF43
	.byte	0x6
	.byte	0x2d
	.long	0x2ae
	.byte	0x49
	.uleb128 0x7
	.long	.LASF44
	.byte	0x6
	.byte	0x2e
	.long	0x2b4
	.byte	0x4d
	.uleb128 0x7
	.long	.LASF45
	.byte	0x6
	.byte	0x30
	.long	0x65
	.byte	0x51
	.uleb128 0x7
	.long	.LASF46
	.byte	0x6
	.byte	0x31
	.long	0x65
	.byte	0x55
	.uleb128 0x7
	.long	.LASF47
	.byte	0x6
	.byte	0x32
	.long	0x65
	.byte	0x59
	.byte	0
	.uleb128 0xc
	.byte	0x4
	.long	0x1c4
	.uleb128 0xc
	.byte	0x4
	.long	0x10d
	.uleb128 0xc
	.byte	0x4
	.long	0x7c
	.uleb128 0xf
	.long	.LASF49
	.byte	0x4
	.long	0x49
	.byte	0x7
	.byte	0x4
	.long	0x2ef
	.uleb128 0x10
	.long	.LASF50
	.byte	0
	.uleb128 0x10
	.long	.LASF51
	.byte	0x1
	.uleb128 0x10
	.long	.LASF52
	.byte	0x2
	.uleb128 0x10
	.long	.LASF53
	.byte	0x3
	.uleb128 0x10
	.long	.LASF54
	.byte	0x4
	.uleb128 0x10
	.long	.LASF55
	.byte	0x5
	.byte	0
	.uleb128 0x11
	.long	.LASF56
	.byte	0x1
	.byte	0x1b
	.long	.LFB3
	.long	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x11
	.long	.LASF57
	.byte	0x1
	.byte	0x24
	.long	.LFB4
	.long	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x11
	.long	.LASF58
	.byte	0x1
	.byte	0x58
	.long	.LFB5
	.long	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x12
	.long	.LASF59
	.byte	0x6
	.byte	0x37
	.long	0x2a8
	.uleb128 0x12
	.long	.LASF60
	.byte	0x1
	.byte	0x15
	.long	0x2b4
	.uleb128 0x13
	.long	.LASF61
	.byte	0x1
	.byte	0x17
	.long	0x349
	.uleb128 0x5
	.byte	0x3
	.long	VERSION
	.uleb128 0xc
	.byte	0x4
	.long	0x34f
	.uleb128 0x14
	.long	0x37
	.uleb128 0x13
	.long	.LASF62
	.byte	0x1
	.byte	0x18
	.long	0x349
	.uleb128 0x5
	.byte	0x3
	.long	AUTHOR
	.uleb128 0x13
	.long	.LASF63
	.byte	0x1
	.byte	0x19
	.long	0x349
	.uleb128 0x5
	.byte	0x3
	.long	MODIFIER
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
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x9
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
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0xf
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
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
	.uleb128 0x10
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
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
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x13
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
	.uleb128 0x14
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
.LASF39:
	.string	"elem_foreground"
.LASF44:
	.string	"console"
.LASF41:
	.string	"time_sched"
.LASF2:
	.string	"BOOL"
.LASF60:
	.string	"cur_console"
.LASF35:
	.string	"priority"
.LASF47:
	.string	"exit_status"
.LASF52:
	.string	"SYS_WAIT"
.LASF33:
	.string	"state"
.LASF7:
	.string	"short int"
.LASF17:
	.string	"sizetype"
.LASF57:
	.string	"main_init"
.LASF66:
	.string	"/media/jahn/External1/os/p3/ssuos/src/kernel"
.LASF55:
	.string	"SYS_NUM"
.LASF26:
	.string	"PROC_UNUSED"
.LASF20:
	.string	"head"
.LASF53:
	.string	"SYS_SSUREAD"
.LASF54:
	.string	"SYS_SHUTDOWN"
.LASF3:
	.string	"bool"
.LASF31:
	.string	"process"
.LASF46:
	.string	"child_pid"
.LASF42:
	.string	"parent"
.LASF5:
	.string	"long long int"
.LASF18:
	.string	"Console"
.LASF62:
	.string	"AUTHOR"
.LASF50:
	.string	"SYS_FORK"
.LASF15:
	.string	"sum_y"
.LASF38:
	.string	"elem_stat"
.LASF21:
	.string	"tail"
.LASF0:
	.string	"unsigned char"
.LASF40:
	.string	"time_used"
.LASF65:
	.string	"arch/Main.c"
.LASF6:
	.string	"signed char"
.LASF56:
	.string	"ssuos_main"
.LASF9:
	.string	"long long unsigned int"
.LASF43:
	.string	"kbd_buffer"
.LASF4:
	.string	"unsigned int"
.LASF30:
	.string	"PROC_BLOCK"
.LASF32:
	.string	"stack"
.LASF22:
	.string	"list_elem"
.LASF28:
	.string	"PROC_STOP"
.LASF8:
	.string	"short unsigned int"
.LASF1:
	.string	"char"
.LASF48:
	.string	"p_state"
.LASF37:
	.string	"elem_all"
.LASF58:
	.string	"print_contributors"
.LASF19:
	.string	"Kbd_buffer"
.LASF36:
	.string	"time_slice"
.LASF61:
	.string	"VERSION"
.LASF63:
	.string	"MODIFIER"
.LASF14:
	.string	"buf_p"
.LASF34:
	.string	"time_sleep"
.LASF12:
	.string	"buf_s"
.LASF27:
	.string	"PROC_RUN"
.LASF13:
	.string	"buf_w"
.LASF25:
	.string	"pid_t"
.LASF45:
	.string	"simple_lock"
.LASF59:
	.string	"cur_process"
.LASF51:
	.string	"SYS_EXIT"
.LASF16:
	.string	"used"
.LASF64:
	.string	"GNU C11 5.4.0 20160609 -m32 -mtune=generic -march=i686 -g -O0 -ffreestanding -fno-stack-protector"
.LASF29:
	.string	"PROC_ZOMBIE"
.LASF23:
	.string	"prev"
.LASF10:
	.string	"Glob_x"
.LASF11:
	.string	"Glob_y"
.LASF49:
	.string	"SYS_LIST"
.LASF24:
	.string	"next"
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
