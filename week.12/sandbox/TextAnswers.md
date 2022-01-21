Topic 1 - Compiler and Basics

1. Breaking things
    What happens in hello.c when the include statement is removed?
        the program encounters an error
    What happens when the return statement either changes its' value or is removed?
        the program still runs
    
2. Bugs
    What are the three things missing?
        There is no include statement, meaning printf won't work
        There is no semicolon to end the print statement
        There are no comments

Topic 2 - Variables and Memory

1. The meaning of variables
    What is the meaning of char c = 'a';
        Declares the variable c as a character and assigns it the character a
    
2. Bugs and compiler feedback
    Errors in the program:
        1. Variables were not defined before they were assigned
        2. The second printf statement was missing a % symbol
        3. Third print statement uses %i for integers but is passed a double (1.1)
        4. Return statement is commented out because /* is used instead of //
        5. Newline characters are missing at the end of the printf statements
        6. Printf statements all say value of x instead of value of their respective variables

3. Fixing bugs before the compiler
    Bugs in the program:
        1. There should not be a semicolon after the include statement
        2. No end double quotes in first printf statement
        3. Error with 1point1 variable because although variables can contain digits, they cannot start with them
        4. Missing semicolon after second printf statement
        5. In second print statement, variable a is printed in integer format (97) because of the use of %i instead of %c

5. Playing with different variables
    What happens if incompaible constant types are assigned to variables (e.g. int x = 'a';)?
        If possible, the variable is interpreted as the constant type it is defined as. E.g. the above example outputs 97 instead of a. In cases where an integer/float is assigned to a char type, nothing is printed unless it is between quotes.

6. Memory
    What is the biggest integer you can declare to int?
        Between 200-300 million. After this, x returns random negative numbers and even larger numbers  return an error. 
        The maximum possible value for a variable of type int is 2147483647.
        This is because an int is a 32 bit number and half is reserved for positive numbers and half for negative numbers. 32 all-1 bits is equivalent to this number.

7. Floating point binary
    What is the difference between integral and floating point binary?
        In integral binary (fixed point representation), the binary point is set in a specific place and so the allocation of the bits between the whole part and fractional part cannot change

        ** ask in Q and A
    What does a web search on floating point binary return?

Topic 3 - Operators, expressions and typecasting

Example 1
    
    Before program runs, i guess that the following will happen:
        c will equal 3.5
    This did not happen. 3 was returned. Why?
        This is because by using the / operator on variables, any decimal answer is truncated.
    What if the answer is assigned to a float?
        The answer is still truncated, and espressed with zeros after the decimal point


        