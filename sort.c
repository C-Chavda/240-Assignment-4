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