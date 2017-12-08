  BITS 64

  global solve
  global solve_2

solve:
  xor eax, eax                  ; is there any point of this on modern processors?
  lea rsi, [rdi+8*rsi]          ; convert offset to position
  .loop:
  mov rcx, [rdi]                ; store offset
  inc qword [rdi]               ; bump up offset
  lea rdi, [rdi+rcx*8]          ; add offset
  inc eax
  cmp rdi, rsi                  ; hit the end yet?
  jl .loop
  ret

solve_2:
  xor eax, eax                  ; is there any point of this on modern processors?
  lea rsi, [rdi+8*rsi]          ; convert offset to position
  .loop:
  mov rcx, [rdi]                ; store offset
  cmp rcx, 2
  lea r8, [rcx+1]
  lea rdx, [rcx-1]
  cmovle rdx, r8
  mov [rdi], rdx
  lea rdi, [rdi+rcx*8]          ; add offset
  inc eax
  cmp rdi, rsi                  ; hit the end yet?
  jl .loop
  ret
