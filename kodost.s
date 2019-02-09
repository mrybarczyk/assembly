	.intel_syntax noprefix
	.global main

	.text

main:
	xor ecx, ecx
	xor edx, edx
	mov eax, [esp+8]
	mov eax, [eax+4]


first:
	call ifend
	je exit
	
	cmp bl, 'p'
	je negone
	cmp bl, 'q'
	je negone
	cmp bl, 'r'
	je negone

	inc ecx
	inc edx
	jmp first


negone:
	inc edx

	call ifend
	je exit
	
	cmp bl, 't'
	jne negtwo
	je restart

negtwo:
	cmp bl, 'q'
	jne negthree
	je restart
	
negthree:
	cmp bl, 'r'
	jne plus
	je restart
	
plus:
	inc edx

	call ifend
	je exit

	cmp bl, 't'
	je restart

	cmp bl, 'q'
	je restart

	cmp bl, 'r'
	je printing

	jmp plus

restart:
	mov ecx, edx
	jmp first

ifend:
	mov bl, [eax+edx]
	cmp bl, 0
	ret
	
printing:
	mov bl, 0
	mov [eax+edx+1], bl
	lea ebx, [eax+ecx]
	push ebx
	mov ebx, offset output_string
	push ebx
	call printf
	add esp, 8

	jmp exit
	
exit:
	xor eax, eax
	ret
	
	.data

output_string:	 .asciz "%s\n"
