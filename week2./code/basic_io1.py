#!/usr/bin/env python3

"""Importing and exporting data in python"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

###############
# FILE INPUT
###############

# Open a file for reading
f = open('../sandbox/test.txt', 'r') # Open the file to read

print("First example:", "\n")
# use "implicit" for loop:
# if the object is a file, python will cycle over its' lines
for line in f:
    print(line)
# prints each line from the file

# close the file
f.close()

# Same example, skip blank lines
f = open('../sandbox/test.txt', 'r') # open the file to read

print("Second example:", "\n")
for line in f:
    if len(line.strip()) > 0: 
        #checks if line is empty
        #.strip() removes any leading or trailing spaces (so that if a line has only spaces, it will be recognised as empty)
        print(line)
# makes sure that each element (line of text) is separated by only one empty line, removes unnecessary empty lines

f.close()


