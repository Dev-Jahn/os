org 0x7c00				;로드된 부트코드의 위치인 0x7c00을 base로 설정
[BITS 16]

START:   
mov		ax, 0xb800			;비디오램의 주소 저장
mov		es, ax				;es레지스터로 복사
mov		ax, 0x00			;화면 지우기에 사용할 값(검은색)
mov		bx, 0				;출력 시작위치 0으로 설정
mov		cx, 80*25*2			;25라인까지 출력하도록 카운터 설정
mov 	si, 0				;문자열 시작위치 0으로 설정

WRITE:
mov 	dl, byte[msg+si]	;문자열 한바이트 복사
mov		byte[es:bx], dl		;비디오램에 문자 쓰기
inc 	bx					;오프셋 증가
mov 	byte[es:bx], 0x07	;검은 배경에 흰 글씨
inc 	bx					;오프셋 증가
inc 	si					;문자열 인덱스 증가
or 		dl, dl				;dl이 0이면(문자열 끝이면)  결과가 0
jnz 	WRITE				;or의 결과가 0이 아니면 WRITE로 점프

CLS:
mov		[es:bx], ax			;검은색으로 칠
add		bx, 1				;오프셋 증가
loop 	CLS					;반복(cx 1씩 감소)

msg	db "Hello, Jaehan's World", 0 ;문자열과 0을 바이트단위 데이터로 저장
