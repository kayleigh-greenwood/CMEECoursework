#!/usr/bin/env python3

""" Intro to profiling 2 """

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys 
import numpy as np

## functions 
def my_squares(iters):
    ## list comprehension method - removes 1 second ##
    out = [i ** 2 for i in range(iters)]
    return out

def my_squares_array(iters):
    ## preallocation method - preallocate a numpy array instead of a list for mysquares - removes even more time ##
    out = np.array(range(iters))
    out =  out ** 2
    return out

def my_join(iters, string):
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

## main entry point
def run_my_funcs(x,y):
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

if __name__ == "__main__":
    status = run_my_funcs(10000000,"My string")
    sys.exit(status)
