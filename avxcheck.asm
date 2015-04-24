	;; Will Dignazio
	;; AVX Check Utility

	section .text
	global _start

%define AVX 0x018000000

%macro  print 1
	section .data
  .str	db %1,10,0
  .len  equ $ - .str

	section .text
	mov     ecx, .str
	mov     edx, .len
	mov     ebx,1
	mov     eax,4
	int     0x80
%endmacro
	
_start:
	mov eax, 1
	cpuid

	and ecx, AVX
	cmp ecx, AVX
	jne enosup

	print "AVX instructions are supported."
	mov eax, 1
	int 0x80
	
enosup:
	print "AVX instructions are NOT supported."
	mov eax, 1
	int 0x80

	
	section .data
	okmsg   db  'AVX instructions are supported',0xa
	oklen   equ $ - okmsg

	nomsg   db  'AVX instructions are not supported',0xa
	nolen   equ $ - nomsg
