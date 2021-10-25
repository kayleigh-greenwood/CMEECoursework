#!/usr/bin/env python3

"""Exporting data into a file in python"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'


###############
# FILE OUTPUT
###############

list_to_save = range(100) # creates a list with numbers from 0 to 99

f = open('../sandbox/testout.txt','w') # open a file to write
for i in list_to_save: # for each element in the list
    f.write(str(i) + '\n') # Add each element to a new line in the opened file

print("File ../sandbox/testout.txt has been edited.")

f.close()

