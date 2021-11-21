#!/usr/bin/env python3

""" Intro to profiling """

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys 
# sys is a module that interfaces our program with the operating system


## define functions ##
def my_squares(iters):
    """Creates list containing the square of all items in iters """
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """Creates string of 'iters' amount of repeats of 'string' separated by commas"""
    out = ''
    for i in range(iters):
        out += string.join(", ")
        # appends value of 'string' to 'out', followed by comma
    return out

## Main entry point ##
def run_my_funcs(x,y):
    """ Runs my_squares and my_join """
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

if __name__ == "__main__":
    status = run_my_funcs(10000000,"My string")
    sys.exit(status)