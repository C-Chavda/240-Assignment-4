; Program name: "Random Number Normalization"
; This program fills an array with up to 100 elements with random numbers and normalizes them to the range of 1.0 to 2.0.
; Copyright (C) <2025>  

; This file is part of the software program "Random Number Normalization".

; Random Number Normalization is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; Random Number Normalization is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program. If not, see https://www.gnu.org/licenses/.

; Author Information
;   Author Name  : Chandresh Chavda
;   Author Email : chav349@csu.fullerton.edu
;   Author Section: 240-11
;   Author CWID  : 885158899

; External dependencies
extern printf
extern isnan

global fill_random_array

segment .data
; Debug formats (unused in final version)
debug_format db 10, "%d  %d", 10, 0 
float_display dq "%18.13g", 0

segment .bss
; No uninitialized data needed

segment .text
fill_random_array:
    ; Backup GPRs (matches executive.asm style)
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

    ; Store parameters (matches executive.asm names)
    mov r15, rdi        ; my_array pointer
    mov r14, rsi        ; array_size
    xor r13, r13        ; counter = 0

array_fill_loop:
    ; Check if array is full
    cmp r13, r14
    jge fill_complete

generate_number:
    ; Generate random number
    rdrand r12
    jnc generate_number  ; Retry if carry not set

    ; Check for NaN
    mov [rsp-16], r12    ; Temporary store
    movsd xmm0, [rsp-16]
    call isnan
    test rax, rax
    jnz generate_number  ; If NaN, try again

    ; Store valid number
    mov [r15 + r13*8], r12
    inc r13
    jmp array_fill_loop

fill_complete:
    ; Restore GPRs (matches executive.asm order)
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