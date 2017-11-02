**CSCI 3415 – Principles of Programming Languages**

Programming Assignment 3 – Ada

Due Nov. 8, 2017 

-----------------
# Part I - Installing a Compiler 

> 
The GNU Compiler Collection (GCC) includes front ends for C, C++, Objective-C, Fortran, Java, Ada,and Go, as well as libraries for these languages. Therefore, it can be used for many of the programmingassignments for this class. The GCC web site is http://gcc.gnu.org.The GCC is available for many platforms. It is a standard part of almost all Linux distributions. You could use any Linux distribution or other platform. For Windows I recommend TDM-GCC, which is available from http://tdm-gcc.tdragon.net/. 
>

-----------------

# Part II – Generic Unbounded_Stack 

The second part of this assignment is to get the generic unbounded stack package and string reverse procedure working in your Ada development environment. The source code is included at the end of this assignment. After you get it running, add the function Top (S : Stack) return Item_Type, which returns the top item on the stack or raises the Underflow exception, to the generic unbounded stack package. Which will be needed for the calculator program.

-----------------

# Part III - Calculator Program

The main part of this assignment is to implement a simple integer calculator with binary operators  addition, subtraction, multiplication, and division - no unary operators. Use the algorithm we will go over in class. There are two stacks: and operator stack and an operand stack. 

> 
The operator stack can be a stack of characters representing the pending operators (or an enumeration type if you prefer) and the operand stack is a stack of integers. 
The program reads a string and goes through it left to right (in a single pass). When an operand (an integer) is encountered, it is pushed onto the operand stack.
When an operator is encountered, all of the pending operators (on the operator stack) whose precedence is higher or equal to the current operator are applied (see the next paragraph) and then the current operator is pushed onto the operator stack. This continues until there are no more characters in the string. At this point, apply any remaining pending operators (on the operator stack) and the single value remaining on the operand stack is the value of the expression. 
If there is not exactly one operand on the operand stack, then the expression is not valid. 
Applying an operator means to pop the operator off the top of the operator stack and pop two operands off the operand stack (the right one then the left one). The. perform the corresponding operation (add, subtract, multiple, or divide) on the operands, being careful of their order, and push the result on the operand stack. 
If there are not two operands on the stack, then the expression is not valid. 
For a full grade, you will extend the program to support floating point numbers and finally to support parenthesized sub-expressions.You can decide how to handle 'illegal' characters (those other than digits, +, -, *, or /) - either ignore them or raise an error. [Or some combination like ignore spaces and signal an error for others.]
> 


# Specifics 

-----------------
Write a set of Ada programs as defined above and, as usual, provide write up describing the program.
Use your program to compute the value of ten expressions, including two invalid ones.For a C grade, your program must be able to evaluate integer expressions with no parentheses. For a B grade, your program must be able to evaluate floating-point expressions with no parenthesis. For an A grade, your program must be able to evaluate floating-point expressions with parenthesis. [Remember that these are the minimum requirements. You are also graded on the content of your report.]



