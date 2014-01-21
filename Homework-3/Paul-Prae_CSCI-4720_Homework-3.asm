# Name: Paul Prae
# csci 4720
# HW3
# 02/16/2012

.text
.globl global
global:

# $s0 is lowerBound
# $s1 is upperBound
# $s2 is the current prime to test and then print

# Print format and introduction
#      Print an empty line
la $a0, CRLF
li $v0, 4
syscall
#      Print two solid lines for clear display
li $v0, 4
la $a0, lineOfEquals
syscall

li $v0, 4
la $a0, lineOfEquals
syscall

li $v0, 4
la $a0, CRLF
syscall

li $v0, 4
la $a0, CRLF
syscall

li $v0, 4 # output string
la $a0, introMessage # store message
syscall

# Print an empty line or two
li $v0, 4
la $a0, CRLF
syscall


# Print the purpose of this program
li $v0, 4
la $a0, rulesMessage
syscall

li $v0, 4
la $a0, CRLF
syscall

li $v0, 4
la $a0, CRLF
syscall

# Request the integer for the lower bound
li $v0, 4
la $a0, inputMessage1
syscall

li $v0, 4
la $a0, CRLF
syscall

# Read lower bound
li $v0, 5 # read int
syscall
sw $v0, lowerBound # store int in memory
lw $s0, lowerBound # store int in register

li $v0, 4
la $a0, CRLF
syscall

# Request the integer for the upper bound
li $v0, 4
la $a0, inputMessage2
syscall

li $v0, 4
la $a0, CRLF
syscall

# Read upper bound
li $v0, 5 # read int
syscall
sw $v0, lowerBound # store int in memory
lw $s1, lowerBound # store int in register

li $v0, 4
la $a0, CRLF
syscall

# Print two solid lines for clear displaying of results

li $v0, 4
la $a0, lineOfEquals
syscall

li $v0, 4
la $a0, lineOfEquals
syscall

li $v0, 4
la $a0, CRLF
syscall

li $v0, 4
la $a0, CRLF
syscall

# Print Primes

la $a0, numbersMessage # tell the user what is happening
li $v0, 4
syscall

la $a0, ($s0) # print out lower bound
li $v0, 1
syscall

la $a0, andSpaces # print and spaces
li $v0, 4
syscall

la $a0, ($s1) # print out upper bound
li $v0, 1
syscall

la $a0, colon # print out colon
li $v0, 4
syscall

li $v0, 4
la $a0, CRLF
syscall

# Print Primes?

jal main




li $v0, 4
la $a0, CRLF
syscall

li $v0, 4
la $a0, CRLF
syscall

li $v0, 4
la $a0, lineOfEquals
syscall

li $v0, 4
la $a0, lineOfEquals
syscall

li $v0, 4
la $a0, CRLF
syscall

li $v0, 4
la $a0, endOfLine
syscall

# Exit program
li $v0, 10
syscall

##########
# Procedures
##########
main:
add $t7, $ra, $zero # save $ra in $t7

addi $t6, $zero, 1 # set the integer start counter 
addi $t5, $zero, 200 # set the amount of primes to compute
addi $t4, $zero, 0 # set the prime counter

loopMain:
addi $t6, $t6, 1 #increment integer
add $a0, $t6, $zero # load the current integer into the argument param
jal is_prime # check if the current integer is prime
beq $v0, 1, weGotPrime # if it is prime go to label
continueLoop:
slt $t3, $t4, $t5 # check to see if we have gathered enough primes yet
beq $t3, 1, loopMain


add $ra, $t7, $zero # put $ra back to where it was
jr $ra # end main

weGotPrime:
addi $t4, $t4, 1 # increment primes found counter 
add $a0, $t6, $zero # load the current integer into the argument param
jal check_prime # see if the prime is in the range given by the user
beqz $v0, continueLoop # if it is not then just skip the printing
add $a0, $t6, $zero # load the current integer into the argument param
jal print_int
j continueLoop

is_prime:
add $t1, $a0, $zero # load current prime into $t1
li $t0, 1 # set counter to start at 1
li $v0, 1 # assume it is prime

loopIsPrime:
addi $t0, $t0, 1 # increment counter
beq $t0, $t1, primeFound # if $t0 is equal to the current prime then exit loop
div $t1, $t0 # divide the prime by the counter
mfhi $t2 # move from hi to $t2
beq $t2, $zero, notPrime # if there is no remainder then it is not prime
j loopIsPrime

notPrime:
li $v0, 0 # set return value to 0 for false
jr $ra

primeFound:
li $v0, 1 # set rturn value to 1 for true
jr $ra

check_prime:
add $t0, $a0, $zero # load current prime into $t1

addi $t2, $s0, 1 # increment lower bound because of inclusion
slt $t1, $t0, $t2 # true if the current prime is less than the lower bound
beq $t1, 1, notInRange # if above is true that the prime out of range

slt $t1, $t0, $s1 # return true if the current prime is less than the upper bound
beq $t1, 1, inRange # If the above is true than the current prime is in range

notInRange:
li $v0, 0 # set return value to 0 for false
jr $ra

inRange:
li $v0, 1 # set return value to 1 for true
jr $ra

print_int:
 # print out integer is argument register
li $v0, 1
syscall
li $v0, 4
la $a0, CRLF
syscall

jr $ra

squareRoot:
jr $ra

##########
# Data
##########
	.data
Space: .asciiz "          "
introMessage: .ascii " Welcome to Paul Prae's Homework 3"
 .asciiz " for Taha's 4720 class!"
rulesMessage: .ascii " This program will compute the first 200"
 .asciiz " prime numbers."
inputMessage1: .ascii " Please type the lower bound of the range for output,"
 .asciiz "\nend the line with the Enter Key: "
 inputMessage2: .ascii " Please type the upper bound of the range for output,"
 .asciiz "\nend the line with the Enter Key: "
numbersMessage: .asciiz "The Prime numbers between "
lineOfEquals: .asciiz "=============================="
andSpaces: .asciiz " and "
colon: .asciiz ":"

lowerBound: .word 0 #The exclusive lower bound of the range
upperBound: .word 0 #The exclusive upper bound of the range

CRLF: .byte 10,0
endOfLine: .asciiz "\n"
test1: .asciiz "test1: "
test2: .asciiz "test2: "
test3: .asciiz "test3: "
test4: .asciiz "test4: "
test5: .asciiz "test5: "

#End of file.
