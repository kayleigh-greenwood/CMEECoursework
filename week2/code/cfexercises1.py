#!/usr/bin/env python3

"""Intro to conditionals and functions"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys # sys is a module that interfaces our program with the operating system

## functions ##

def foo_1(x=4):
    """return the square root of x"""
    return x ** 0.5

def foo_2(x=2,y=5):
    """return whichever number is bigger, unless they are equal, in which case return y."""
    if x > y:
        return x
    return y

def foo_3(x=4, y=10, z=6):
    """ensure the largest number is at the end of the sequence. Use tmp to store values whilst swapping values around"""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x=4):
    """calculate the factorial of x"""
    result = 1
    for i in range(1, x + 1): #creates a loop running from 1 to x (x + 1 will display x because of python's indexing starting at 0, the loop stops just before the end of the range)
        result = result * i # multiplies the current iteration by the previous one. same function as factorial
    return result

def foo_5(x=4):
    """Calculate the factorial of x, recursively"""
    if x == 1:
        return 1
    return x * foo_5(x - 1) # loop will recursively call itself until it gets down to 1, and will cycle back up again

def foo_6(x=4):
    """Calculate the factorial of x"""
    facto = 1 # sets a variable, facto, to 1
    while x >= 1: #runs this loop whilst x is greater than or equal to 1.
        facto = facto * x #multiplies the current iteration by the previous one
        x = x - 1 #removes one from x to continue down the while loop
    return facto #once the while loop has reached 1, the value of facto is returned, giving the factorial value of x.

def main(argv):
    """main entry point of the program"""
    print(f"The square root of 6 is: {foo_1(6)} \n")
    print(f"The largest number out of 5 and 12 is: {foo_2(5,12)} \n")
    print(f"The modified sequence with the largest number at the end is: {foo_3(34,7,12)} \n")
    print(f"The factorial of 5 is: {foo_4(5)} \n")
    print(f"The factorial of 6 is: {foo_5(6)} \n")
    print(f"The factorial of 7 is: {foo_6(7)} \n")
    return 0

if __name__ == "__main__":
    """Make sure the "main" function is called from command line"""
    status = main(sys.argv) # directs the interpreter to pass the argument variables to the main function
    sys.exit(status) #exits the program explicitly, returning an appropriate status code  (in this code, main states above that it will return 0, so 0 is returned)
