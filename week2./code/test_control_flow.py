#!/usr/bin/env python3

""" Some functions exemplifying the use of control statements"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys # sys is a module that interfaces our program with the operating system
import doctest 

##functions##
def even_or_odd(x=0):
    """Find whether a number x is even or odd.
      
    >>> even_or_odd(10)
    '10 is Even!'
    
    >>> even_or_odd(5)
    '5 is Odd!'
    
    whenever a float is provided, then the closest integer is used:    
    >>> even_or_odd(3.2)
    '3 is Odd!'
    
    in case of negative numbers, the positive is taken:    
    >>> even_or_odd(-2)
    '-2 is Even!'
    
    """ 
    # simple tests for each function are embedded in the docstring
    # doctest will try and run the tests within the docstrings, and if they match the expected output, the test is successful
    # >>> section specifies which function should be tested and which arguments passed to it
    # the line below tells doctest which output we want that function to give
    # we must specify what is the correct output before running doctest, otherwise doctest can't know if the function is running correctly
    #Define function to be tested
    if x % 2 == 0:
        return "%d is Even!" % x
    return "%d is Odd!" % x

def main(argv): 
    """main entry point of the program"""
    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()   # To run with embedded tests (don't have to specify doctest from the command line)