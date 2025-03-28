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


global show_array
extern printf

segment .data
; Updated to match exact sample formatting
array_header db "IEEE754            Scientific Decimal", 10, 0
number_format db "0x%016lX        % .13e", 10, 0  ; Space for positive numbers

segment .bss
align 64
register_store resb 832  ; Renamed from storedata

segment .text
show_array:
    ; Backup all registers
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8 
    push r9 
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Backup SSE state
    mov rax, 7
    mov rdx, 0
    xsave [register_store]

    ; Initialize counters - using same names as previous version
    xor r13, r13        ; counter (was index)
    mov r14, rdi        ; array pointer (my_array)
    mov r15, rsi        ; element count (array_size)

    ; Print header
    mov rax, 0
    mov rdi, array_header 
    call printf 

display_loop:
    cmp r13, r15
    jge display_complete
    
    ; Display each number
    mov rax, 1
    mov rdi, number_format  
    mov rsi, [r14 + r13 * 8]    ; Hex value
    movsd xmm0, [r14 + r13 * 8] ; Decimal value
    call printf   

    inc r13      
    jmp display_loop

display_complete:
    ; Restore SSE state
    mov rax, 7
    mov rdx, 0
    xrstor [register_store]

    ; Restore all registers
    popf          
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9 
    pop r8 
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret