#include <device/kbd.h>
#include <type.h>
#include <device/console.h>
#include <proc/proc.h>
#include <interrupt.h>
#include <device/io.h>
#include <ssulib.h>

static Key_Status KStat;

static char kbd_buf[BUFSIZ];
int buf_head, buf_tail;
//위 전역변수를 사용하는 코드를 cur_foreground_process를 사용하는 코드로 변경
extern struct process *cur_foreground_process;
Kbd_buffer kbd_buffer[MAX_KBD_BUFFER];

static BYTE Kbd_Map[4][KBDMAPSIZE] = {
	{ /* default */
		0x00, 0x00, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b', '\t',
		'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', 0x00, 'a', 's',
		'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', 0x00, '\\', 'z', 'x', 'c', 'v',
		'b', 'n', 'm', ',', '.', '/', 0x00, 0x00, 0x00, ' ', 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, '-', 0x00, 0x00, 0x00, '+', 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	},
	{ /* capslock */
		0x00, 0x00, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b', '\t',
		'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', '\n', 0x00, 'A', 'S',
		'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', '\'', '`', 0x00, '\\', 'Z', 'X', 'C', 'V',
		'B', 'N', 'M', ',', '.', '/', 0x00, 0x00, 0x00, ' ', 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, '-', 0x00, 0x00, 0x00, '+', 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	},
	{ /* Shift */
		0x00, 0x00, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b', 0x00,
		'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', 0x00, 0x00, 'A', 'S',
		'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '\"', '~', 0x00, '|', 'Z', 'X', 'C', 'V',
		'B', 'N', 'M', '<', '>', '?', 0x00, 0x00, 0x00, ' ', 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, '-', 0x00, 0x00, 0x00, '+', 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	},
	{ /* Capslock & Shift  */
		0x00, 0x00, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '\b', 0x00,
		'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '{', '}', 0x00, 0x00, 'a', 's',
		'd', 'f', 'g', 'h', 'j', 'k', 'l', ':', '\"', '~', 0x00, '|', 'z', 'x', 'c', 'v',
		'b', 'n', 'm', '<', '>', '?', 0x00, 0x00, 0x00, ' ', 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, '-', 0x00, 0x00, 0x00, '+', 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	}
};

static bool kbd_remove_char();

void init_kbd(void)
{
	KStat.ShiftFlag = 0;
	KStat.CapslockFlag = 0;
	KStat.NumlockFLag = 0;
	KStat.ScrolllockFlag = 0;
	KStat.ExtentedFlag = 0;
	KStat.PauseFlag = 0;

	buf_head = 0;
	buf_tail = 0;

	reg_handler(33, kbd_handler);
}

void UpdateKeyStat(BYTE Scancode)
{
	//on key release
	if(Scancode & 0x80)
	{
		//on shift release
		if(Scancode == 0xB6 || Scancode == 0xAA)
		{
			KStat.ShiftFlag = FALSE;
		}
		//on ctrl release
		if(Scancode == 0x9D)
		{
			KStat.CtrlFlag = FALSE;
		}
	}
	//on key press
	else
	{
		if(Scancode == 0x3A && KStat.CapslockFlag)
		{
			KStat.CapslockFlag = FALSE;
		}
		else if(Scancode == 0x3A)
			KStat.CapslockFlag = TRUE;
		//on left or right shift press
		else if(Scancode == 0x36 || Scancode == 0x2A)
		{
			KStat.ShiftFlag = TRUE;
		}
		else if(Scancode == 0x1D)
		{
			KStat.CtrlFlag = TRUE;
		}
	}

	//ExtendedFlag On*Off
	if(Scancode == 0xE0)
	{
		KStat.ExtentedFlag = TRUE;
	}
	else if(KStat.ExtentedFlag == TRUE && Scancode != 0xE0)
	{
		KStat.ExtentedFlag = FALSE;
	}
}

BOOL ConvertScancodeToASCII(BYTE Scancode, BYTE *Asciicode)
{
	if(KStat.PauseFlag > 0)
	{
		KStat.PauseFlag--;
		return FALSE;
	}

	if(KStat.ExtentedFlag == TRUE)
	{
		if(Scancode & 0x80)	
			return FALSE;
		*Asciicode = Scancode;
		return TRUE;
	}

	if(Scancode == 0xE1)
	{
		*Asciicode = 0x00;
		KStat.PauseFlag = 2;
		return FALSE;
	}
	else if(Scancode == 0xE0)
	{
		*Asciicode = 0x00;
		return FALSE;
	}

	if(!(Scancode & 0x80))
	{
		if(KStat.ShiftFlag & KStat.CapslockFlag)
		{
			*Asciicode = Kbd_Map[3][Scancode & 0x7F];
		}
		else if(KStat.ShiftFlag)
		{
			*Asciicode = Kbd_Map[2][Scancode & 0x7F];
		}
		else if(KStat.CapslockFlag)
		{
			*Asciicode = Kbd_Map[1][Scancode & 0x7F];
		}
		else
		{
			*Asciicode = Kbd_Map[0][Scancode];
		}

		return TRUE;
	}
	return FALSE;
}

bool isFull()
{
	return (buf_head-1) % BUFSIZ == buf_tail;
}

bool isEmpty()
{
	return buf_head == buf_tail;
}

void kbd_handler(struct intr_frame *iframe)
{
	BYTE asciicode;
	BYTE data = inb(0x60);

	if(ConvertScancodeToASCII(data, &asciicode))
	{

#ifdef SCREEN_SCROLL
		/*printk("%d\n", data);*/
		/*printk("%d\n", asciicode);*/
		if( KStat.ExtentedFlag == TRUE)
		{
			switch(asciicode)
			{
				case 72://UP
					break;
				case 80 ://DOWN
					break;
				case 75 ://LEFT
					break;
				case 77 ://RIGHT
					break;
				case 73 :// PageUp
					scroll_screen(-1);
					break;
				case 81 :// PageDown
					scroll_screen(+1);
					break;
				case 79 ://End
					set_fallow();
					break;
				default:
					break;
			}
		}
		//when ctrl is down
		else if( KStat.CtrlFlag == TRUE)
		{
			switch(asciicode)
			{
				extern int sum_y;
				extern char *buf_s;
				extern char *buf_p;
				extern char *buf_w;
				case 9:		// Ctrl+Tab
					next_foreground_proc();
					break;
				case 108:	// Ctrl+L
					clearScreen();
					break;
				default:
					break;
			}
		}
		else if( !isFull() && asciicode != 0)
		{
			kbd_buf[buf_tail] = asciicode;
			buf_tail = (buf_tail + 1) % BUFSIZ;
		}

#endif
		
	}
	UpdateKeyStat(data);
}

char kbd_read_char()
{
	if( isEmpty())
		return -1;

	char ret;
	ret = kbd_buf[buf_head];
	buf_head = (buf_head + 1)%BUFSIZ;
	return ret;
}

//입력 버퍼 할당
struct Kbd_buffer *get_kbd_buffer(){
	int i;

	for(i = 0; i < MAX_KBD_BUFFER; i++){
		if(kbd_buffer[i].used == false){
			kbd_buffer[i].used = true;
			return &kbd_buffer[i];
		}
	}

	return NULL;
}
