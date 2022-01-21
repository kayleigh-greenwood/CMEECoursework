#!/usr/bin/env python3

"""Examples of for and while loops"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## BLOCK 1

print("\n", "Block 1:")
_a_global = 10 # a global variable (because it is assigned outside of a function)

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable (still outside of a function, if statement isnt a function)

print ("Before calling a function, outside the function, the value of _a_global is", _a_global)
print ("Before calling a function, outside the function, the value of _b_global is", _b_global)

def a_function():
    """Demonstrate basic rules of variable scope"""
    _a_global = 4 
    # a local variable
    # value has been changed only inside the function. 
    # variable will still hold the old value outside of the function

    if _a_global >= 4:
        _b_global = _a_global + 5 
        # value of b_global has been updated inside the function so old value will still apply outside

    _a_local = 3 
    # created inside the function so doesn't exist outside

    print ("inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("inside the function, he value of _a_local is", _a_local)

    return None

a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a function, outside the function, the value of _b_global is (still)", _b_global)

try:
    print("After calling a_function, outside the function, the value of _a_local is ", _a_local)
except:
    print ("After calling a_function, outside the function, _a_local does not exist")


## BLOCK 2
print("\n", "Block 2")
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    """Example of local variables"""
    _a_local = 4
    # created inside a function so won't exist outside

    print("Inside the function, the value of _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)

    return None

a_function()

print("Outside the fuction, the value of _a_global is", _a_global)


# BLOCK 3
print("\n", "Block 3")
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    """Demonstrate the global keyword"""
    global _a_global
    # the global keyword changes the rules such that
    # any changes made inside the function 
    # will apply to the global space
    _a_global = 5 # will now also be updated outside of the function
    _a_local = 4 # is local so only exists inside the function

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _a_local is", _a_local)

    return None

a_function()

print("After calling a_function, outside the function, the value of _a_global is", _a_global)
try:
    print("After calling a_function, outside the function, the value of _a_local is ", _a_local)
except:
    print ("ERROR: After calling a_function, outside the function, _a_local does not exist")

## BLOCK 4
print("\n", "Block 4")

def a_function():
    """demonstrate variable scope in nested functions"""
    _a_global = 10 # local variable, has been created inside the function
    # doesn't exist in the global space

    def _a_function2():
        """create a global variable within a nested function"""
        global _a_global 
        # changes the rules such that 
        # any changes made to _a_global will apply in the current function, and the global workspace
        _a_global = 20
        print("Inside the second function, the value of _a_global is", _a_global)



    # even though _a_global has been made global,
    # the changes only apply to the global workspace, 
    # and the function in which the variable was assigned global status
    # and because it was assigned global status inside a nested funciton,
    # the changes will not apply to the first iteration of the function, 
    # only the nested one

    print("Inside the first function, before calling the second function, value of _a_global is", _a_global)

    _a_function2()

    print("Inside the first function, after calling the second function, value of _a_global is", _a_global)
    # when _a_global was redefined in _a_function2, it redefined the value in the global workspace but NOT inside a_function
    # because a_function is pulling it's value of _a_global from within its own function, it remains as 10
    return None

try:
    print("Before calling a_function, outside the function, the value of _a_global is ", _a_global)
except:
    print ("Before calling a_function, outside the function, _a_global does not exist")

a_function()

print("After calling the function, the value of a_global in main workspace / namespace is", _a_global)

## BLOCK 5
print("\n", "Block 5")
_a_global = 10

print("Before calling a function, the value of _a_global is", _a_global)

def a_function():
    """manipulate variable values"""

    print("Within the first function, before calling the second function, value of _a_global is", _a_global)

    def _a_function2():
        """assign variables"""
        global _a_global # assigned global status
        _a_global = 20
        print("Within the second (nested) function, the value of _a_global is", _a_global)


    _a_function2()

    print("Within the first function, after calling the nested function, the value of _a_global is", _a_global)
    # as opposed to above, the value of _a_global is being pulled from the global workspace, so has been updated to 20.
    # in block 4, it was pulling a value from within its function which had not been updated
    # here, the value of _a_global being pulled is from the global workspace, which courtesy of the nested function, was updated to 20.

a_function()

print("After calling the function, the value of a_global in main workspace / namespace is", _a_global)

