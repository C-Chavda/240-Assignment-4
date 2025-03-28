

//  Program name: "Random Number Normalization"
//  This program fills an array with up to 100 elements with random numbers and normalizes them to the range of 1.0 to 2.0.
// Copyright (C) <2025>  

//  This file is part of the software program "Random Number Normalization".

//  Random Number Normalization is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.

//  Random Number Normalization is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with this program. If not, see https://www.gnu.org/licenses/.

//  Author Information
//    Author Name  : Chandresh Chavda
//    Author Email : chav349@csu.fullerton.edu
//    Author Section: 240-11
//    Author CWID  : 885158899


#include <stdio.h>
#include <string.h>

// Declare the assembly function
extern char* executive();

int main() {
    printf("Welcome to Random Products, LLC.\n");
    printf("This software is maintained by Chandresh Chavda\n");
    
    char* name;
    name = executive();
    
    printf("Oh, %s. We hope you enjoyed your arrays. Do come again.\n", name);
    printf("A zero will be returned to the operating system.\n");
    
    return 0;
}