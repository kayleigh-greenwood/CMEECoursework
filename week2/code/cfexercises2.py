### FOR loops ###

print ('function a')

def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')


hello_1(12)

# hello is printed 4 times
# inputs which print hello: 0, 3, 6, 9

print ('function b')

def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)

# hello is printed 4 times
# inputs which print hello: 3, 7, 8, 11

print ('function c')

def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

# i predict hello will be printed 14 times
# hello is printed for every input number

### WHILE loops ###

print ('function d')
def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

# hello is printed 5 times
# inputs that print hello: 0, 3, 6, 9, 12

print ('function e')
def hello_5(x):
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


print ('function f')
def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

# hello is printed 14 times (same amount of input numbers)


