org	0x7c00   

[BITS 16]

START:   
		jmp		BOOT1_LOAD ;BOOT1_LOAD로 점프

BOOT1_LOAD:
	mov     ax, 0x0900 
        mov     es, ax
        mov     bx, 0x0

        mov     ah, 2		;섹터읽기
        mov     al, 0x4		
        mov     ch, 0	
        mov     cl, 2	
        mov     dh, 0		
        mov     dl, 0x80

        int     0x13	
        jc      BOOT1_LOAD

PRINT_INIT:
		mov		ax, 0xb800	;비디오메모리 주소 로드
		mov		es, ax		;es에 할당
		mov		ax, 0x00	;ax에 속성값 넣기
		mov		bx, 0		;출력시작 오프셋
		mov 	cx, 80*2*25	;CLS반복 횟수 지정
		mov 	si, 0		;si초기화
CLS:						;화면 클리어
		mov		[es:bx], ax
		add		bx, 1	   
		loop 	CLS		   
		mov 	bx, 0

LIST1:									;첫줄 출력
		mov 	dl, byte[ssuos_1+si]	
		mov		byte[es:bx], dl		
		inc 	bx					
		mov 	byte[es:bx], 0x07	
		inc 	bx					
		inc 	si					
		or 		dl, dl				
		jnz 	LIST1	
		mov 	bx, 80*2
		mov 	si, 0
LIST2:									;둘째줄 출력
		mov 	dl, byte[ssuos_2+si]	
		mov		byte[es:bx], dl		
		inc 	bx					
		mov 	byte[es:bx], 0x07	
		inc 	bx					
		inc 	si					
		or 		dl, dl				
		jnz 	LIST2	
		mov 	bx, 80*4
		mov 	si, 0
LIST3:									;셋째줄 출력
		mov 	dl, byte[ssuos_3+si]	
		mov		byte[es:bx], dl		
		inc 	bx					
		mov 	byte[es:bx], 0x07	
		inc 	bx					
		inc 	si					
		or 		dl, dl				
		jnz 	LIST3	
mov 	bx, 0		;첫 줄에
call 	SELECTOR	;셀렉터 출력
KEY_INT:			;키보드 인터럽트 대기
		mov 	ah, 0x00
		int 	0x16
		cmp		ah, 0x48
		je		UP
		cmp 	ah, 0x50
		je 		DOWN
		cmp 	ah, 0x1c
		je 		ENTER
		jne		KEY_INT
UP:						;위 방향키 누르면
		dec		bx		;1감소
		cmp 	bx, 0	;0보다 작으면 2로 변경
		jge		U2		;0이상이면 그대로 출력
		mov 	bx, 2
	U2:	call SELECTOR	;변경된 위치에 셀렉터 출력
		jmp 	KEY_INT
DOWN:
		inc		bx
		cmp 	bx, 3
		jl		D2
		mov 	bx, 0
	D2:	call SELECTOR
		jmp 	KEY_INT
ENTER:
		jmp KERNEL_LOAD

SELECTOR:
		push 	ax
		push	bx		;출력위치 스택에 저장
		mov 	bx, 2
		mov 	cx, 3
		mov 	si, 0
	REMOVE:				;기존 셀렉터 삭제
		mov		byte[es:bx], 0x00
		inc 	bx					
		mov 	byte[es:bx], 0x00	
		dec		bx
		add 	bx, 80*2
		loop 	REMOVE

		mov 	bx, [esp]		;출력위치 복원
		mov		ax, bx
		mov 	bx, 80*2
		mul 	bx
		mov 	bx, ax
	PRINT:				;새 셀렉터 출력
		mov 	dl, byte[select+si]	
		mov		byte[es:bx], dl		
		inc 	bx					
		mov 	byte[es:bx], 0x07	
		inc 	bx					
		inc 	si					
		or 		dl, dl				
		jnz 	PRINT
		pop 	bx
		pop 	ax
		ret

KERNEL_LOAD:
	mov     ax, 0x1000	
        mov     es, ax		
		cmp		bx, 1		;1이면 커널2 로드
		je 		P2
		cmp		bx, 2		;2면 커널3 로드
		je 		P3
	P1:
        mov     bx, 0x0		
        mov     ah, 2		;섹터읽기
        mov     al, 0x3f	;읽을 섹터 수
        mov     ch, 0		;실린더
        mov     cl, 0x06	;섹터
        mov     dh, 0x00   	;헤드
        mov     dl, 0x80  	;드라이브
		jmp 	DISK_INT
	P2:
        mov     bx, 0x0		
        mov     ah, 2		;섹터읽기
        mov     al, 0x3f	;읽을 섹터 수
        mov     ch, 0x09	;실린더
        mov     cl, 0x2f	;섹터
        mov     dh, 0x0e   	;헤드
        mov     dl, 0x80  	;드라이브
		jmp 	DISK_INT
	P3:
        mov     bx, 0x0		
        mov     ah, 2		;섹터읽기
        mov     al, 0x3f	;읽을 섹터 수
        mov     ch, 0x0e	;실린더
        mov     cl, 0x07	;섹터
        mov     dh, 0x0e   	;헤드
        mov     dl, 0x80  	;드라이브
		jmp 	DISK_INT
	DISK_INT:
        int     0x13		;디스크 인터럽트
        jc      KERNEL_LOAD
;수정

jmp		0x0900:0x0000

select db "[O]",0
ssuos_1 db "[ ] SSUOS_1",0
ssuos_2 db "[ ] SSUOS_2",0
ssuos_3 db "[ ] SSUOS_3",0
partition_num : resw 1

times   446-($-$$) db 0x00

PTE:
partition1 db 0x80, 0x00, 0x00, 0x00, 0x83, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x3f, 0x0, 0x00, 0x00
partition2 db 0x80, 0x00, 0x00, 0x00, 0x83, 0x00, 0x00, 0x00, 0x10, 0x27, 0x00, 0x00, 0x3f, 0x0, 0x00, 0x00
partition3 db 0x80, 0x00, 0x00, 0x00, 0x83, 0x00, 0x00, 0x00, 0x98, 0x3a, 0x00, 0x00, 0x3f, 0x0, 0x00, 0x00
partition4 db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
times 	510-($-$$) db 0x00
dw	0xaa55
