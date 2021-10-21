

# what does each of foo_x do?

def foo_1(x):
    return x ** 0.5
# returns the square root of x

def foo_2(x,y):
    if x > y:
        return x
    return y
# returns whichever number is bigger, unless they are equal, in which case it returns y.

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

 # ensures the largest number is at the end of the sequence.
 # uses tmp to store values whilst it is swapping values around



def foo_4(x):
    result = 1
    for i in range(1, x + 1): #creates a loop running from 1 to x (x + 1 will display x because of python's indexing starting at 0, the loop stops just before the end of the range)
        result = result * i # multiplies the current iteration by the previous one. same function as factorial
    return result
# calculates factorial of x

def foo_5(x): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1) # loop will recursively call itself until it gets down to 1, and will cycle back up again

def foo_6(x): # calulate the factorial of x in a different way
    facto = 1 # sets a variable, facto, to 1
    while x >= 1: #runs this loop whilst x is greater than or equal to 1.
        facto = facto * x #multiplies the current iteration by the previous one
        x = x - 1 #removes one from x to continue down the while loop
    return facto #once the while loop has reached 1, the value of facto is returned, giving the factorial value of x.