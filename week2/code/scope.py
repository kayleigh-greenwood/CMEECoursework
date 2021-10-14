## BLOCK 1

_a_global = 10 # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable

print ("Before calling a function, outside the function, the value of _a_global is", _a_global)
print ("Before calling a function, outside the function, the value of _b_global is", _b_global)

def a_function():
    _a_global = 4 # a local variable

    if _a_global >= 4:
        _b_global = _a_global + 5 #also a local variable

    _a_local = 3

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
    print ("ERROR: After calling a_function, outside the function, _a_local does not exist")


## BLOCK 2

_a_global = 10

def a_function():
    _a_local = 4

    print("Inside the function, the value of _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)

    return None

a_function()

print("Outside the fuction, the value of _a_global is", _a_global)


## BLOCK 3

_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    global _a_global_
    _a_global = 5
    _a_local = 4

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _a_local is", _a_local)

    return None

a_function()

print("After calling a_function, outside the function, the value of _a_global is", _a_global)


## BLOCK 4

def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling a function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling _a_function2, value of _a_global is", _a_global)
    # when _a_global was redefined in _a_function2, it redefined the value in the general workspace but NOT inside a_function
    # because a_function2 is pulling the value of _a_global from within the function before it and NOT the global workspace, it remains as 10
    return None

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)

## BLOCK 5

_a_global = 10

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20

    print("Before calling a function, value of _a_global is", _a_global)

    _a_function2()

    print("After calling _a_function2, value of _a_global is", _a_global)
    # as opposed to above, the value of _a_global is being pulled from the global workspace, it has been updated to 20.

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)

