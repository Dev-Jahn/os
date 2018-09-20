org	0x9000  

[BITS 16]  

		cli		; Clear Interrupt Flag

		mov     ax, 0xb800 
        mov     es, ax
        mov     ax, 0x00
        mov     bx, 0
        mov     cx, 80*25*2 
CLS:
        mov     [es:bx], ax
        add     bx, 1
        loop    CLS 
 
Initialize_PIC:
		;ICW1 - 두 개의 PIC를 초기화 
		mov		al, 0x11
		out		0x20, al
		out		0xa0, al

		;ICW2 - 발생된 인터럽트 번호에 얼마를 더할지 결정
		mov		al, 0x20
		out		0x21, al
		mov		al, 0x28
		out		0xa1, al

		;ICW3 - 마스터/슬레이브 연결 핀 정보 전달
		mov		al, 0x04
		out		0x21, al
		mov		al, 0x02
		out		0xa1, al

		;ICW4 - 기타 옵션 
		mov		al, 0x01
		out		0x21, al
		out		0xa1, al

		mov		al, 0xFF
		;out		0x21, al
		out		0xa1, al

Initialize_Serial_port:
		xor		ax, ax		;ax 0으로
		xor		dx, dx		;dx 0으로
		mov		al, 0xe3	;9600,8,N,1 시리얼 설정
		int		0x14		;시리얼포트 접근 인터럽트

READY_TO_PRINT:
		xor		si, si		;si 0으로
		xor		bh, bh		;bh 0으로
PRINT_TO_SERIAL:
		mov		al, [msgRMode+si]	;문자열에서 한바이트 al에 복사
		mov		ah, 0x01			;문자열전송코드 설정
		int		0x14				;시리얼포트 접근 인터럽트
		add		si, 1				;오프셋 증가
		cmp		al, 0				;al 0과 비교(문자열 끝 확인)
		jne		PRINT_TO_SERIAL		;다르면 반복
PRINT_NEW_LINE:
		mov		al, 0x0a	;al에 라인피드
		mov		ah, 0x01	;문자열전송코드
		int		0x14		;시리얼포트 접근
		mov		al, 0x0d	;al에 캐리지리턴
		mov		ah, 0x01	;문자열전송코드
		int		0x14		;시리얼포트 접근

Activate_A20Gate:
		mov		ax,	0x2401
		int		0x15

;Detecting_Memory:
;		mov		ax, 0xe801
;		int		0x15

PROTECTED:
        xor		ax, ax		;ax 0으로
        mov		ds, ax		;ds 0으로

		call	SETUP_GDT	;ip스택에 넣고 SETUP_GDT로 점프

        mov		eax, cr0	;cr0 컨트롤레지스터 eax로 복사
        or		eax, 1	  	;첫번째 1비트 켜기(PE비트)
        mov		cr0, eax  	;cr0로 다시 복사

		jmp		$+2	;지연분기를 위해 파이프라인에 리얼모드의 코드가 삽입되는 것을 방지
		nop			;do nothing
		nop			;do nothing
		jmp		CODEDESCRIPTOR:ENTRY32

SETUP_GDT:
		lgdt	[GDT_DESC]	;gdtr레지스터에 gdt크기, 시작주소 등록
		ret		;ip스택에서 꺼내 호출위치로 귀환

[BITS 32]  

ENTRY32:
		mov		ax, 0x10	;데이터세그먼트디스크립터 지정
		mov		ds, ax		;세그먼트 레지스터 초기화
		mov		es, ax
		mov		fs, ax
		mov		gs, ax

		mov		ss, ax
  		mov		esp, 0xFFFE
		mov		ebp, 0xFFFE	

		mov		edi, 80*2		;한줄 띄우기
		lea		esi, [msgPMode]	;문자열 주소 로드
		call	PRINT			;PRINT 서브루틴 호출

		;IDT TABLE
	    cld
		mov		ax,	IDTDESCRIPTOR
		mov		es, ax
		xor		eax, eax
		xor		ecx, ecx
		mov		ax, 256
		mov		edi, 0
 
IDT_LOOP:
		lea		esi, [IDT_IGNORE]
		mov		cx, 8
		rep		movsb
		dec		ax
		jnz		IDT_LOOP

		lidt	[IDTR]

		sti
		jmp	CODEDESCRIPTOR:0x10000

PRINT:
		push	eax		;스택에 eax삽입
		push	ebx		;스택에 ebx삽입 
		push	edx		;스택에 edx삽입 
		push	es		;스택에 es삽입 
		mov		ax, VIDEODESCRIPTOR	;비디오디스크립터주소 복사
		mov		es, ax				;비디오디스크립터주소 복사
PRINT_LOOP:
		or		al, al			;종료조건 확인
		jz		PRINT_END		;al이 0이면 종료
		mov		al, byte[esi]	;문자열 
		mov		byte [es:edi], al;160위치에 출력 
		inc		edi				;출력오프셋 증가
		mov		byte [es:edi], 0x07	;검은배경에 흰글씨

OUT_TO_SERIAL:
		mov		bl, al		;문자 bl에 복사
		mov		dx, 0x3fd	;LSR(Line Status Register)주소 복사
CHECK_LINE_STATUS:
		in		al, dx		;LSR로부터 상태읽기
		and		al, 0x20	;THRE비트 and로 mask
		cmp		al, 0		;THRE와 0 비교
		jz		CHECK_LINE_STATUS	;0이면 다시 확인
		mov		dx, 0x3f8	;dx에 COM1 시리얼포트 주소 복사
		mov		al, bl		;al에 문자복사 
		out		dx, al		;시리얼포트로 문자출력

		inc		esi			;문자열 오프셋 증가
		inc		edi			;출력오프셋 증가
		jmp		PRINT_LOOP	;처음으로 점프,다음 글자 출력
PRINT_END:
LINE_FEED:
		mov		dx, 0x3fd	;dx에 LSR포트 복사
		in		al, dx		;LSR에서 상태읽기
		and		al, 0x20	;THRE비트 mask 
		cmp		al, 0		;0과 비교
		jz		LINE_FEED	;0이면 다시확인
		mov		dx, 0x3f8	;dx에 COM1 주소 복사
		mov		al, 0x0a	;라인피드 복사
		out		dx, al		;라인피드 출력
CARRIAGE_RETURN:
		mov		dx, 0x3fd	;dx에 LSR포트 복사
		in		al, dx		;LSR에서 상태읽기
		and		al, 0x20	;THRE비트 mask 
		cmp		al, 0		;0과 비교
		jz		CARRIAGE_RETURN ;0이면 다시확인
		mov		dx, 0x3f8	;dx에 COM1 주소 복사
		mov		al, 0x0d	;라인피드 복사
		out		dx, al		;라인피드 출력

		pop		es			;스택 top에서 es복구
		pop		edx			;스택 top에서 es복구 
		pop		ebx			;스택 top에서 es복구 
		pop		eax			;스택 top에서 es복구 
		ret					;call 위치로 복귀

GDT_DESC:
        dw GDT_END - GDT - 1	;GDT사이즈
        dd GDT					;GDT시작주소
GDT:
		NULLDESCRIPTOR equ 0x00		;심볼 정의
			dw 0 	;limit 15~0비트
			dw 0 	;base adress 15~0비트
			db 0	;base adress 23~16비트
			db 0	;P,DPL,S,세그먼트타입
			db 0	;G,D,AVL limit 19~16비트
			db 0	;base adress 31~24비트
		CODEDESCRIPTOR  equ 0x08 	;심볼 정의(코드세그먼트)
			dw 0xffff	;limit 15~0비트
			dw 0x0000	;base adress 15~0비트
			db 0x00     ;base adress 23~16비트
			db 0x9a     ;P=1, DPL=0, 코드타입, Execute/Read
			db 0xcf     ;G=1, D=1, limit 19~16비트=0xf
			db 0x00     ;base adress 31~24비트
		DATADESCRIPTOR  equ 0x10	;심볼 정의(데이터세그먼트)
			dw 0xffff	;limit 15~0비트
			dw 0x0000	;base adress 15~0비트
			db 0x00		;base adress 23~16비트
			db 0x92		;P=1, DPL=0, 데이터타입, Read/Write
			db 0xcf		;G=1, D=1, limit 19~16비트=0xf
			db 0x00		;base adress 31~24비트
		VIDEODESCRIPTOR equ 0x18	;심볼 정의(비디오세그먼트)
			dw 0xffff	;limit 15~0비트
			dw 0x8000	;base adress 15~0비트
			db 0x0b		;base adress 23~16비트
			db 0x92		;P=1, DPL=0, 데이터타입, Read/Write
			db 0x40		;G=0, D=1, limit 19~16비트=0x0
			db 0x00		;base adress 31~24비트
		IDTDESCRIPTOR	equ 0x20	;심볼 정의(인터럽트)
			dw 0xffff 	;limit 15~0비트
			dw 0x0000	;base adress 15~0비트
			db 0x02		;base adress 23~16비트
			db 0x92		;P=1, DPL=0, 데이터타입, Read/Write
			db 0xcf		;G=1, D=1, limit 19~16비트=0xf
			db 0x00		;base adress 31~24비트
GDT_END:
IDTR:
		dw 256*8-1
		dd 0x00020000
IDT_IGNORE:
		dw ISR_IGNORE
		dw CODEDESCRIPTOR
		db 0
		db 0x8E
		dw 0x0000
ISR_IGNORE:
		push	gs
		push	fs
		push	es
		push	ds
		pushad
		pushfd
		cli
		nop
		sti
		popfd
		popad
		pop		ds
		pop		es
		pop		fs
		pop		gs
		iret



msgRMode db "Real Mode", 0
msgPMode db "Protected Mode", 0

 
times 	2048-($-$$) db 0x00
