#!/usr/bin/env python3

""" Some functions exemplifying the use of control statements"""
# docstrings are considered part of the running code (normal comments are stripped)
# hence, you can access your docstrings at run time.

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import sys # sys is a module that interfaces our program with the operating system

## constants ##

## functions ##
def even_or_odd(x=0): #if not specific, x should take value 0
    """Find whether a number x is even or odd"""
    if x % 2 == 0: # if x is even
        return "%d is Even!" % x # %d specifies decimal format, and %x specifies the values to apply such format to
    return "%d is Odd!" % x

def largest_divisor_five(x=120):
    """Find which is the largest divisor/factor of x among 2,3,4,5."""
    largest = 0
    if x % 5 == 0: # if x is a multiple of 5
        largest = 5
    elif x % 4 == 0: #means "else, if"
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    else: #when all other (if, elif) conditions are not met
        return "No divisor between 1-5 found for %d!" % x # each function can return a value or variable
    return "The largest divisor of %d is %d" % (x, largest)

def is_prime(x=70):
    """Find whether an integer is prime"""
    for i in range(2, x): # "range" returns a sequence of integers from 2 to x-1
        if x % i == 0: # if x is a multiple of i
            print("%d is not a prime: %d is a divisor" % (x, i)) # %d specifies decimal format, and %(x, i) specifies which values to apply that format to
            return False
    print("%d is a prime!" % x)
    return True

def find_all_primes(x = 22):
    """Find all the primes up to x"""
    allprimes = []
    for i in range(2, x + 1): # by specifying x+1, it ensures that x is included in the range, otherwise the range would stop at x-1.
        if is_prime(i):
            allprimes.append(i) # adds only the prime numbers to the prime list
    print("There are %d primes between 2 and %d" % (len(allprimes), x)) # counts the number of prime numbers in the range specified
    return allprimes

def main(argv):
    print(even_or_odd(22), "\n")
    print(even_or_odd(33), "\n")
    print(largest_divisor_five(120), "\n")
    print(largest_divisor_five(121), "\n")
    print(is_prime(60), "\n")
    print(is_prime(59), "\n")
    print(find_all_primes(100), "\n")
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv) # directs the interpreter to pass the argument variables to the main function
    sys.exit(status) #exits the program explicitly, returning an appropriate status code  (in this code, main states above that it will return 0, so 0 is returned)
