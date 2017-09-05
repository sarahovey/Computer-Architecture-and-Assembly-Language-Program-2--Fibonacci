TITLE Program Template     (template.asm)

; Author: Sara Hovey
;
; 
;             Date: 04/23/17
; Description: Given a number, this program displays that many
; Fibbonacci numbers, as well as greets and says goodbye to the user

INCLUDE Irvine32.inc

;Boundaries for range-checking
LOWER = 1
UPPER = 46

.data

;Values from the user
userName	BYTE	30 DUP(0)
nTerms  DWORD	?

;Calculated values
fib		DWORD	?

;Text output
intro_1		BYTE	"Name:Sara, CS271 Program 2, ft. Fibonacci", 0
intro_2		BYTE	"Hello, " , 0
ask_1		BYTE	"What's your name, friend?" , 0
ask_2		BYTE	"Please enter the number of fibonacci terms you would like" , 0
show_1		BYTE	"Here are the terms: ", 0
bye			BYTE	"Goodbye, ", 0
error_1		BYTE	"Please enter a number greater than or equal to 1" , 0
error_2		BYTE	"Please enter a number less than or equal to 46" , 0

.code
main PROC

;Display program title and programmer name
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf

;Get user's name
	mov		edx, OFFSET ask_1
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString

;Greet the user
	mov		edx, OFFSET intro_2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

;Ask for the number of Fib terms
;Prompt

prompt:
	mov		edx, OFFSET ask_2
	call	WriteString
	call	CrLf

;Get data
	call	ReadInt
	mov		nTerms, eax

;Validate
	cmp		eax, UPPER ;Comparing input to the upper limit
	jg		upperExceed ; Jump to this error if the input is > upper limit

	cmp		eax, LOWER ;Comparing input to the lower limit
	jl		lowerExceed ; Jump here if the input < the lower limit

;Set up ecx for looping, and the first two terms
	mov		ecx, nTerms
	mov		eax, 0
	mov		ebx, 1

;Proceed with the rest of the calculation
; Counted loop
calc:
	mov		edx, eax
	add		edx, ebx
	mov		eax, ebx
	mov		ebx, edx
	;print
	call	WriteInt
	;loop
	loop calc


;Error messages
;Exceeds the upper limit of 46
upperExceed:
	mov		edx, OFFSET error_2
	call	WriteString
	call	CrLf
	jmp		prompt	;Jumps back up to re-prompt

;Exceeds the lower limit of 1
lowerExceed:
	mov		edx, OFFSET error_1
	call	WriteString
	call	CrLf
	jmp		prompt

;Say goodbye to the user with their name
	mov		edx, OFFSET bye
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
