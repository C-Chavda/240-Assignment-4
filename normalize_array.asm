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



global normalize_array
extern rdrand
segment .data
segment .bss
    align 64
    fpu_backup resb 832

segment .text
normalize_array:
    ; Execution context preservation
    push        rbp
    mov         rbp, rsp
    
    ; General register protection
    push        r15
    push        r14
    push        r13
    push        r12
    push        r11
    push        r10
    push        r9
    push        r8
    push        rdi
    push        rsi
    push        rdx
    push        rcx
    push        rbx
    pushf

    ; Floating-point state preservation
    mov         rax, 7
    xor         rdx, rdx
    xsave       [fpu_backup]

    ; Initialize processing state
    xor         r12, r12          ; Element counter
    mov         r13, rdi          ; Array base address
    mov         r14, rsi          ; Element count

    ; Constants for bit manipulation
    mov         r10, 0x000FFFFFFFFFFFFF  ; Mantissa mask
    mov         r9, 0x7FF0000000000000   ; Exponent mask
    mov         r8, 0x3FF0000000000000   ; New exponent (1023)

process_element:
    ; Check completion condition
    cmp         r12, r14
    jge         restoration_point

    ; Load current value
    mov         r11, [r13 + r12 * 8]
    
    ; Check for special values (NaN/Inf)
    mov         rax, r11
    and         rax, r9
    cmp         rax, r9
    je          next_element      ; Skip if NaN or Inf
    
    ; Check for zero
    test        r11, r11
    jz          make_one
    
    ; Normal number processing
    and         r11, r10          ; Clear exponent/sign
    or          r11, r8           ; Set exponent to 1023
    jmp         store_value
    
make_one:
    ; Handle zero case - convert to 1.0
    mov         r11, r8
    
store_value:
    mov         [r13 + r12 * 8], r11
    
next_element:
    ; Advance to next element
    inc         r12
    jmp         process_element

restoration_point:
    ; Restore floating-point state
    mov         rax, 7
    xor         rdx, rdx
    xrstor      [fpu_backup]

    ; Restore general registers
    popf
    pop         rbx
    pop         rcx
    pop         rdx
    pop         rsi
    pop         rdi
    pop         r8
    pop         r9
    pop         r10
    pop         r11
    pop         r12
    pop         r13
    pop         r14
    pop         r15
    pop         rbp

    ret