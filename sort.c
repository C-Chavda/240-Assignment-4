// ; Program name: "Random Number Normalization"
// ; This program fills an array with up to 100 elements with random numbers and normalizes them to the range of 1.0 to 2.0.
// ; Copyright (C) <2025>  

// ; This file is part of the software program "Random Number Normalization".

// ; Random Number Normalization is free software: you can redistribute it and/or modify
// ; it under the terms of the GNU General Public License as published by
// ; the Free Software Foundation, either version 3 of the License, or
// ; (at your option) any later version.

// ; Random Number Normalization is distributed in the hope that it will be useful,
// ; but WITHOUT ANY WARRANTY; without even the implied warranty of
// ; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// ; GNU General Public License for more details.

// ; You should have received a copy of the GNU General Public License
// ; along with this program. If not, see https://www.gnu.org/licenses/.

// ; Author Information
// ;   Author Name  : Chandresh Chavda
// ;   Author Email : chav349@csu.fullerton.edu
// ;   Author Section: 240-11
// ;   Author CWID  : 885158899

#include <math.h> // Add this at the top for fabs()

void sort(double* my_array, int array_size)
{
    double hold;
    int i, j;
    
    for (i = 0; i < array_size; i++)
    {
        for (j = 0; j < array_size - i - 1; j++)
        {
            if (fabs(my_array[j]) > fabs(my_array[j+1]))  // Compare absolute values
            {
                hold = my_array[j];
                my_array[j] = my_array[j+1];
                my_array[j+1] = hold;
            }
        }
    }
}
