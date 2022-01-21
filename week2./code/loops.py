#!/usr/bin/env python3

"""Examples of for and while loops"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

# FOR loops in Python

for i in range(5): #range functions stop one number before the one specified, as python indexing starts at 0.
    print(i)

print("\n")

my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)

print("\n")

total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands: # s represents each item being looped through in the list
    total = total + s 
    # this function adds the first and second number, prints the total, then adds the third and prints, and so on.
    print(total)

print("\n")

# WHILE loops in Python
z = 0
while z < 100:
    z = z + 1
    print(z)

print("\n")

b = True
while b:
    print("GERONIMO! infinite loop! ctrl+c to stop!")
    # will continue infinitely unless b is changed inside the loop
# ctrl + c to stop
