# Postfix-Calculator
Calculate operations and translate from infix notation to postfix notation (reverse polish)


## Requirements
gcc compiler

bison (sudo apt install bison)

flex (sudo apt install flex) 

#### Tested on:
gcc version 7.3.0 (Ubuntu 7.3.0-27ubuntu1~18.04)

bison (GNU Bison) 3.0.4

flex 2.6.4

## Run
Simply ```make``` and ```./main```

## Example
```
$./main 
2+3*(4-5)
2 3 4 5 - * + 
= -1
2^3^2
2 3 2 ^ ^ 
= 512
2*+2
syntax error
5--4
5 4 ~ - 
= 9
# ~ is unary minus
```
