#  Program name: "Random Number Normalization"
#  This program fills an array with up to 100 elements with random numbers and normalizes them to the range of 1.0 to 2.0.
#  Copyright (C) <2025>  

#  This file is part of the software program "Random Number Normalization".

#  Random Number Normalization is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  Random Number Normalization is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see https://www.gnu.org/licenses/.

#  Author Information
#    Author Name  : Chandresh Chavda
#    Author Email : chav349@csu.fullerton.edu
#    Author Section: 240-11
#    Author CWID  : 885158899

rm *.o
rm *.out

nasm -f elf64 -o executive.o executive.asm

nasm -f elf64 -o show_array.o show_array.asm

nasm -f elf64 -o fill_array.o fill_random_array.asm

nasm -f elf64 -o isnan.o isnan.asm

nasm -f elf64 -o normalize_array.o normalize_array.asm

gcc -c -m64 -Wall -o sort.o sort.c -fno-pie -no-pie -std=c11

gcc -c -m64 -Wall -o main.o main.c -fno-pie -no-pie -std=c11

gcc -m64 -o output.out executive.o fill_array.o main.o show_array.o isnan.o normalize_array.o sort.o -fno-pie -no-pie -std=c11

echo "Execute the program"
chmod +x output.out
./output.out

echo "This bash script will now terminate."