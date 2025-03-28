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

;  External function declarations
extern printf
extern fill_random_array
extern sort
extern show_array
extern normalize_array
extern scanf
extern fgets
extern stdin
extern strlen

global executive

input_max equ 48

segment .data
; User interface strings
name_request db "Please enter your name: ",0
title_request db "Please enter your title (Mr, Ms, Sergeant, Chief, Project Leader, etc): ", 10, 0
welcome_msg db "Nice to meet you %s %s.", 10, 10, 0

program_info db "This program will generate 64-bit IEEE float numbers.", 10, 0
quantity_prompt db "How many numbers do you want. Today's limit is 100 per customer. ", 0
invalid_input db "Size not in range. Try again.", 10, 0
num_format db "%d", 0

; Array display messages
array_ready db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
scaled_msg db 10, "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array.", 10, 10, 0
sorted_output db 10, "The array will now be sorted.", 10, 10, 0
exit_msg db 10, "Good bye %s. You are welcome any time.", 10, 10, 0

segment .bss
align 64
register_store resb 832  ; For xsave/xrstor

; User input buffers
username resb input_max
usertitle resb input_max

; Array storage
float_array resq 100

segment .text
executive:
    ; Prologue - save registers
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

    ; Preserve SSE state
    mov rax,7
    mov rdx,0
    xsave [register_store]

    ; Get user name
    mov rax, 0
    mov rdi, name_request
    call printf
    mov rax, 0
    mov rdi, username
    mov rsi, input_max
    mov rdx, [stdin]
    call fgets

    ; Remove newline from name
    mov rax, 0
    mov rdi, username
    call strlen
    mov [username+rax-1], byte 0

    ; Get user title
    mov rax, 0
    mov rdi, title_request
    call printf
    mov rax, 0
    mov rdi, usertitle
    mov rsi, input_max
    mov rdx, [stdin]
    call fgets

    ; Remove newline from title
    mov rax, 0
    mov rdi, usertitle
    call strlen
    mov [usertitle+rax-1], byte 0

    ; Display welcome message
    mov rax, 0
    mov rdi, welcome_msg
    mov rsi, usertitle
    mov rdx, username
    call printf

get_array_size:
    ; Explain program and get array size
    mov rax, 0
    mov rdi, program_info
    call printf
    mov rax, 0
    mov rdi, quantity_prompt
    call printf

    ; Read integer input
    push qword 0
    push qword 0
    mov rax, 0
    mov rdi, num_format
    mov rsi, rsp
    call scanf
    mov r15, [rsp]
    pop rax
    pop rax

    ; Validate array size (1-100)
    cmp r15, 0
    jl bad_input
    cmp r15, 100
    jg bad_input
    jmp create_array

bad_input:
    mov rax, 0
    mov rdi, invalid_input
    call printf
    jmp get_array_size

create_array:
    ; Generate random numbers
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call fill_random_array

    ; Display initial array
    mov rax, 0
    mov rdi, array_ready
    call printf
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call show_array

    ; Normalize array to [1.0, 2.0)
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call normalize_array

    ; Display normalized array
    mov rax, 0
    mov rdi, scaled_msg
    call printf
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call show_array

    ; Sort the array
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call sort

    ; Display sorted array
    mov rax, 0
    mov rdi, sorted_output
    call printf
    mov rax, 0
    mov rdi, float_array
    mov rsi, r15
    call show_array

    ; Farewell message
    mov rax, 0
    mov rdi, exit_msg
    mov rsi, usertitle
    call printf

    ; Restore SSE state
    mov rax,7
    mov rdx,0
    xrstor [register_store]

    ; Return username to caller
    mov rax, username

    ;restore registers
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