for j in range(12):
    if j % 3 == 0:
        print('hello')

# I predict hello will be printed 4 times (whenever j has no remainders when divided by 3)
# CORRECT

for j in range (15):
    if j % 5 == 3:
        print('hello')
    elif j % 4 == 3:
        print('hello')

# i predict hello will be printed 5 times (whenever j divided by 5 or 4 gives a remainder of 3)
# CORRECT

z = 0
while z != 15:
    print('hello')
    z = z + 3

#i predict hello will be printed 5 times
#CORRECT

z = 12
while z < 100:
    if z == 31:
        for k in range(7):
            print('hello')
    elif z == 18:
        print('hello')
    z = z + 1

#i predict hello will be printed 8 times
# CORRECT