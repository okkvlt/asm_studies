section .text

global _start
_start:
    mov ebx, 0
    ; Registrador armazenando o primeiro
    ; argumento que será passado para
    ; a syscall armazenada no registrador 'eax'.
    ; Argumento: 0.
    
    mov eax, 1
    ; Registrador armazenando a syscall
    ; que será chamada.
    ; Syscall: 1 (exit()).
    
    int 0x80
    ; Execução da syscall armazenada no registrador
    ; 'eax' passando o argumento armazenado em 'ebx'.
    ; Ou seja, instrução que executa a syscall exit(0).

;Compilação:

;$ nasm -f elf32 exit.asm
;$ ld -m elf_i386 -s exit.o -o exit

;Execução do programa:

;$ ./exit

;Análise do programa:

;$ strace ./exit

;O comando strace rastreia todas as syscalls chamadas
;pelo programa em questão e retorna todas elas.

; objdump -D exit

;O comando objdump -D disassembla o programa executável
;e mostra, simulando, o código assembly por detrás.