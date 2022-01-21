#!/usr/bin/env python3

"""Example Script to practice running scripts on"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## function
def foo(x):
    """print the square of the input"""
    print(f"The square of", x, "is:")
    x *= x # same as x = x*x
    print(x)

## code
foo(2)