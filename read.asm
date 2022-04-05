section .data

    escreva db "Escreva: "
    len_escreva equ $-escreva

    recebido db "Recebido: "
    len_recebido equ $-recebido

    input times 0x64 db 0x0
    ;;reserva 100 bytes de espaço na memoria
    ;;preenche o espaço alocado com o valor nulo (\0, 0x0, 0)

section .text

global _start
_start:
    ;; Chama a syscall write()
    ;; Resultado: write(1, escreva, len_escreva).
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, escreva
    mov edx, len_escreva
    int 0x80

    ;; Chama a syscall read()
    ;; Resultado: read(0, input, 100).
    mov eax, 0x3
    mov ebx, 0x0
    mov ecx, input
    mov edx, 0x64
    int 0x80

    ;; Chama a syscall write()
    ;; Resultado: write(1, recebido, len_recebido).
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, recebido
    mov edx, len_recebido
    int 0x80
    
    ;; Chama a syscall write()
    ;; Resultado: write(1, input, 100).
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, input
    mov edx, 0x64
    int 0x80

    ;; Chama a syscall exit()
    ;; Resultado: exit(0).
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80