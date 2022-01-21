#!/usr/bin/env python3

"""Demonstrating how __name__ works"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is: " + __name__)
