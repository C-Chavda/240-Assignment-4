global isnan

segment .data
; No initialized data needed

segment .bss
; No uninitialized data needed

segment .text
isnan:
    ; Backup all GPRs (as in original)
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Efficient NaN check using ucomisd + setp
    ucomisd xmm0, xmm0
    setp al              ; AL=1 if NaN, 0 otherwise
    movzx rax, al        ; Zero-extend to RAX

    ; Restore all GPRs (as in original)
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ret