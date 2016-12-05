.section .data	
	strimg: .ascii ",,ANa*/Vol.im1ilOv///aNa\0"
    pomocni_string: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	greska: .byte 0
.section .text
.global main
main:
	movl $strimg, %esi
    movl $0, %ecx
    movl $0, %edx
na_kraj:                        # pomjera pokazivac do kraja stringa
	cmpb $0, 1(%esi)
	je set_pointers
	incl %esi
	jmp na_kraj
set_pointers:                   # priprema pokazivace za rad
	movl %esi, %edi
	movl $strimg, %esi
je_li_slovo:                      #----rad sa slovima i punjenje pomocnog stringa-------#
    cmpb $0, strimg(,%ecx,1)
    je provjera
    cmpb $'A' , strimg(,%ecx,1)        
    jb nije_slovo
    cmpb $'Z' , strimg(,%ecx,1)
    jbe veliko_slovo
    cmpb $'z' , strimg(,%ecx,1) 
    ja nije_slovo
    cmpb $'a' , strimg(,%ecx,1) 
    jae malo_slovo
    jmp nije_slovo
veliko_slovo:
    addb $32, strimg(,%ecx,1)
    jmp napuni_pomocni
malo_slovo:
    jmp napuni_pomocni
nije_slovo:
    incl %ecx
    jmp je_li_slovo
napuni_pomocni:
    movb strimg(,%ecx,1), %al
    movb %al, pomocni_string(,%edx,1)
    incl %edx
    incl %ecx
    jmp je_li_slovo
pripremi_pomocni:                       #rad sa pomocnim stringom
    movl $pomocni_string, %esi
na_kraj_p:                       
	cmpb $0, 1(%esi)
	je set_pointers_p
	incl %esi
	jmp na_kraj_p
set_pointers_p:                   
	movl %esi, %edi
	movl $pomocni_string, %esi              
provjera: 
    movb (%esi), %al
	movb (%edi), %bl
	cmpb %bl, (%edi)
	je update
	jmp igreska
update:
	cmpl %edi, %esi
	jae kraj                
	incl %esi
	decl %edi
	jmp provjera
igreska: 
	incb greska                  
kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
	
	
