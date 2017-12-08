BITS 64

section .text

global _start
_start:
  mov rax, 0                    ; SYS_read
  mov rdi, 0                    ; stdin
  mov rsi, input
  mov rdx, 4096
  syscall

  mov rdi, input
  call strlen

  ;; inc rdi
  ;; mov input[rdi], input
  ;; mov input[rdi + 1], 0

  mov rdi, rax
  call sum
  call itoa

  mov rax, 1 ; write?
  mov rdi, 1
  mov rsi, numbuf
  mov rdx, 4096
  syscall

  mov rax, 60
  mov rdi, 0
  syscall

sum:
  xor rdx, rdx
  xor eax, eax
  sub rdi, 2                       ; skip last element, nl
  .loop:
  cmp rdi, rdx
  jbe .end
  movsx ecx, byte input[rdx]
  inc rdx
  cmp cl, byte input[rdx]
  jne .loop
  lea eax, [rax-48 + rcx]
  jmp .loop
  .end:
  movsx ecx, byte input[0]
  cmp cl, input[rdx]
  jne .fin
  lea eax, [rax-48 + rcx]
  .fin
  ret

strlen:
  xor rax, rax
  .loop:
  cmp byte [rdi+rax], 0
  je .end
  inc rax
  jmp .loop
  .end:
  ret


itoa:
    enter 4,0
    lea r8,[numbuf+10]
    mov rcx,10
    mov [rbp-4],dword 0

.divloop:
    xor rdx,rdx
    idiv rcx
    add rdx,0x30
    dec r8
    mov byte [r8],dl
    inc dword [rbp-4]
    cmp rax,0
    jnz .divloop

    mov rax,r8
    mov rcx,[rbp-4]

    leave
    ret

section .data
  fmt db "ans: %l"

section .bss
  align 2
  input resb 4096
  numbuf resb 128
