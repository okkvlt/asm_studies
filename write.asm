section .data
; Seção que armazena os dados que serão
; utilizados no programa.

    string: db "This is a string.", 0xa
    ; Declara uma variável chamada string
    ; dentro da qual é armazenado a frase
    ; "This is a string.\n".
    ; O 0xa, no final, é o \n em ASCII.

    len: equ $-string
    ; Declara uma variável chamada len
    ; dentro da qual é armazenado o tamanho
    ; da variável string.

    ; A expressão "$-string" nada mais faz
    ; que pegar o endereço atual de len ($)
    ; e subtrair com o endereço de string.

    ; Essa subtração resulta no tamanho de string.

section .text
; Seção que armazena as instruções que serão
; utilizadas no programa.

global _start   ; Declaração da função _start
_start:         ; Implementação da função _start
    
    mov eax, 4
    ; Armazena a syscall 4 (write()) para o registrador eax.
    mov ebx, 1
    ; Passa 1 como argumento para write().
    mov ecx, string
    ; Passa a variável string como argumento para write().
    mov edx, len
    ; Passa a variável len como argumento para write().
    int 0x80
    ; Chama e executa a syscall informada com seus respectivos argumentos.
    ; Resultado: write(1, string, len)

    mov eax, 1
    ; Armazena a syscall 1 (exit()) para o registrador eax.
    mov ebx, 0
    ; Passa 0 como argumento para exit().
    int 0x80
    ; Chama e executa a syscall informada com seu respectivo argumento.
    ; Resultado: exit(0)