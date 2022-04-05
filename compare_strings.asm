section .data

    escreva db "Digite a senha: "
    len_escreva equ $-escreva

    senha db "p@ssw0rd", 0xa    ;; É colocado um \n (0xa) no final para que
                                ;; a futura comparação compare até que o usuário
                                ;; pressione Enter.
                                ;; Isso evita que, por exemplo, o usuário escreva
                                ;; "p@ssw0rdaaaaaaaaaaaaaaa" e o programa interprete
                                ;; como se a comparação retornasse igual.
                                ;; Pois para retornar igual, o enter do usuário deve ser
                                ;; No mesmo lugar que o \n de senha.

                                ;; Senha: "p@ssw0rd\n"
                                ;; Usuario: "p@ssw0rd(enter // \n)"
                                ;; Retorno -- IGUAIS

                                ;; Senha: "p@ssw0rd\n"
                                ;; Usuario: "p@ssw0rda" + aaaaaaaaaaa(enter // \n)"
                                ;; Retorno -- DIFERENTES
    len_senha equ $-senha

    correta db "Senha correta! Parabéns!", 0xa
    len_correta equ $-correta

    errada db "Senha errada! Tente novamente!", 0xa
    len_errada equ $-errada

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

    mov esi, senha      ;; Armazena a string senha no registrador esi.
    mov edi, input      ;; Armazena a string input no registrador edi.
    mov ecx, len_senha  ;; Seta o limite do loop como o tamanho da string senha.
    repe cmpsb          ;; Compara cada elemento de senha com o respectivo elemento de input.
                        ;; A comparação ocorre até o loop alcançar seu limite, ou seja,
                        ;; até o loop alcançar o tamanho da string senha.
                        ;; Se o loop terminar e retornar 0, é porque as strings são iguais.
    je equal            ;; Salta para equal se a comparação retornar 0.

    ;; O código continua caso a comparação não retorne 0.
    ;; Chama a syscall write()
    ;; Resultado: write(1, errada, len_errada).
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, errada
    mov edx, len_errada
    int 0x80

    jmp exit

    equal:
        ;; Chama a syscall write()
        ;; Resultado: write(1, correta, len_correta).
        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, correta
        mov edx, len_correta
        int 0x80

        jmp exit

    ;; Chama a syscall exit()
    ;; Resultado: exit(0).
    exit:
        mov eax, 0x1
        mov ebx, 0x0
        int 0x80