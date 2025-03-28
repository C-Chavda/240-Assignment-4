;****************************************************************************************************************************
; Program name: Identify Nans.  This is a driver function used for testing the library function isnan.  This function sets  *
; up a call to isnan.  The user can easily verify the correctness of isnan by visual inspection.                            *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public  *
; License (LGPL3) version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it  *
; will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR*
; PURPOSE.  See the GNU Lesser General Public License for more details.  A copy of the GNU Lesser Public License v3 is      *
; available here: <https://www.gnu.org/licenses/>.                                                                          *
;****************************************************************************************************************************
; Programmer's name: F. Holliday
; Email: holliday@fullerton.edu
; Function name: isnan

; Purpose:  This is a library function.  This function, isnan, will determine if an IEEE float number is a nan or not a nan.

;This implementation of the isnan algorithm is intended to be the simplest and minimalist
;implementation possible.



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
