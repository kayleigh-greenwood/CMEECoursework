#!/usr/bin/env python3

"""Examples of loops and conditionals combined"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

print ('function: hello_1')

def hello_1(x):
    """for each number from zero to x-1, print hello if the number is a multiple fo 3"""
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')


hello_1(12)

# hello is printed 4 times
# inputs which print hello: 0, 3, 6, 9

print ('function: hello_2')

def hello_2(x):
    """for each number from zero to x-1, print hello if the number meets a requirement"""
    for j in range(x):
        if j % 5 == 3: # if the number gives a remainder of 3 when divided by 5
            print('hello')
        elif j % 4 == 3: # if the number gives a remainder of 4 when divided by 4
            print('hello')
    print(' ')

hello_2(12)

# hello is printed 4 times
# inputs which print hello: 3, 7, 8, 11

print ('function: hello_3')

def hello_3(x, y):
    """Print hello for each number from x to y-1"""
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

# i predict hello will be printed 14 times
# hello is printed for every input number

### WHILE loops ###

print ('function: hello_4')
def hello_4(x):
    """for every number from 0 to x-l, print hello and add 3 until 15 is reached"""
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

# hello is printed 5 times
# inputs that print hello: 0, 3, 6, 9, 12

print ('function: hello_5')
def hello_5(x):
    """for every number from 0 to x-1, print hello if it meets certain requirements"""
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

# hello printed 8 times


print ('function: hello_6')
def hello_6(x, y):
    """for every number from x to y-1, print hello"""
    for i in range(x, y):
        print('hello')
    print(' ')

hello_6(3, 17)

# hello is printed 14 times (same amount of input numbers)


