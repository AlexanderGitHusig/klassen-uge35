2.6 The Bash Shell Constructs
The Korn and Bash shells are very similar, but there are some differences. The Bash constructs are listed in Table 2.4.

Table 2.4. Bash Shell Syntax and Constructs
The shbang line

The "shbang" line is the very first line of the script and lets the kernel know what shell will be interpreting the lines in the script. The shbang line consists of a #! followed by the full pathname to the shell, and can be followed by options to control the behavior of the shell.

EXAMPLE

#!/bin/bash

Comments

Comments are descriptive material preceded by a # sign. They are in effect until the end of a line and can be started anywhere on the line.

EXAMPLE

# This is a comment

Wildcards

There are some characters that are evaluated by the shell in a special way. They are called shell metacharacters or "wildcards." These characters are neither numbers or letters. For example, the *, ?, and [ ] are used for filename expansion. The <, >, 2>, >>, and | symbols are used for standard I/O redirection and pipes. To prevent these characters from being interpreted by the shell they must be quoted.

EXAMPLE


rm *; ls ??; cat file[1-3];
echo "How are you?"
Displaying output

To print output to the screen, the echo command is used. Wildcards must be escaped with either a backslash or matching quotes.

EXAMPLE

echo "How are you?"

Local variables

Local variables are in scope for the current shell. When a script ends, they are no longer available; i.e., they go out of scope. Local variables can also be defined with the built-in declare function. Local variables are set and assigned values.

EXAMPLE


variable_name=value
declare variable_name=value

name="John Doe"
x=5
Global variables

Global variables are called environment variables and are created with the export built-in command. They are set for the currently running shell and any process spawned from that shell. They go out of scope when the script ends.

The built-in declare function with the -x option also sets an environment variable and marks it for export.

EXAMPLE


export VARIABLE_NAME=value
declare -x VARIABLE_NAME=value
export PATH=/bin:/usr/bin:.
Extracting values from variables

To extract the value from variables, a dollar sign is used.

EXAMPLE


echo $variable_name
echo $name
echo $PATH
Reading user input

The user will be asked to enter input. The read command is used to accept a line of input. Multiple arguments to read will cause a line to be broken into words, and each word will be assigned to the named variable.

EXAMPLE


echo "What is your name?"
read name
read name1 name2 ...
Arguments

Arguments can be passed to a script from the command line. Positional parameters are used to receive their values from within the script.

EXAMPLE

At the command line:

$ scriptname arg1 arg2 arg3 ...

In a script:

echo $1 $2 $3  Positional parameters

echo $*                All the positional paramters

echo $#                The number of positional parameters

Arrays

The Bourne shell utilizes positional parameters to create a word list. In addition to positional parameters, the Bash shell supports an array syntax whereby the elements are accessed with a subscript, starting at 0. Bash shell arrays are created with the declare -a command.

EXAMPLE


set apples pears peaches (positional parameters)
echo $1 $2 $3

declare -a array_name=(word1 word2 word3 ...)
declare -a fruit=( apples pears plums )
echo ${fruit[0]}
Command substitution

Like the C/TC shells and the Bourne shell, the output of a UNIX/Linux command can be assigned to a variable, or used as the output of a command in a string, by enclosing the command in backquotes. The Bash shell also provides a new syntax. Instead of placing the command between backquotes, it is enclosed in a set of parentheses, preceded by a dollar sign.

EXAMPLE


variable_name=`command`
variable_name=$( command )
echo $variable_name

echo "Today is `date`"
echo "Today is $(date)"
Arithmetic

The Bash shells support integer arithmetic. The declare -i command will declare an integer type variable.The Korn shell's typeset command can also be use for backward compatibility. Integer arithmetic can be performed on variables declared this way. Otherwise the (( )) (let command ) syntax is used for arithmetic operations.

EXAMPLE

declare -i variable_name    used for bash

typeset -i variable_name    can be used to be compatible with ksh

(( n=5 + 5 ))
echo $n

Operators

The Bash shell uses the built-in test command operators to test numbers and strings, similar to C language operators.

EXAMPLE

Equality:	Logical:
==   equal to	  &&   and
!=   not equal to	  ||  or
 	  !  not
Relational:	 
>   greater than	 
>=   greater than, equal to	 
<   less than	 
<=   less than, equal to	 
 	 
 

Conditional statements

The if construct is followed by an expression enclosed in parentheses. The operators are similar to C operators. The then keyword is placed after the closing paren. An if must end with an endif. The new [[ ]] test command is now used to allow pattern matching in conditional expressions. The old [ ] test command is still available for backward compatibility with the Bourne shell. The case command is an alternative to if/else.

EXAMPLE

The if construct is:

if  command
then
   block of statements
fi

if  [[ expression  ]]
then
   block of statements
fi

if  (( numeric expression  ))
then
   block of statements
else
   block of statements
 fi
The if/else construct is:

if  command
then
   block of statements
else
   block of statements
fi

if  [[ expression ]]
then
   block of statements
else
   block of statements
fi

if  ((  numeric expression ))
then
   block of statements
else
   block of statements
fi
The case construct is:

case variable_name in
   pattern1)
      statements
         ;;
   pattern2)
      statements
         ;;
   pattern3)
         ;;
esac

case "$color" in
   blue)
      echo $color is blue
         ;;
   green)
      echo $color is green
         ;;
   red|orange)
      echo $color is red or orange
         ;;
   *) echo "Not a matach"
         ;;
esac
The if/else/else if construct is:

if  command
then
   block of statements
elif  command
then
   block of statements
else if  command
then
   block of statements
else
   block of statements
fi
-------------------------
if  [[ expression ]]
then
   block of statements
elif  [[  expression ]]
then
   block of statements
else if  [[  expression ]]
then
   block of statements
else
   block of statements
fi
--------------------------
if  ((  numeric expression ))
then
   block of statements
elif  ((  numeric expression ))
then
   block of statements
else if  ((numeric expression))
then
   block of statements
else
   block of statements
fi
Loops

There are four types of loops: while, until, for, and select.

The while loop is followed by an expression enclosed in square brackets, a do keyword, a block of statements, and terminated with the done keyword. As long as the expression is true, the body of statements between do and done will be executed. The compound test operator [[ ]] is new with Bash, and the old-style test operator [ ] can still be used to evaluate conditional expressions for backward compatibility with the Bourne shell.

The until loop is just like the while loop, except the body of the loop will be executed as long as the expression is false.

The for loop is used to iterate through a list of words, processing a word and then shifting it off, to process the next word. When all words have been shifted from the list, it ends. The for loop is followed by a variable name, the in keyword, a list of words, then a block of statements, and terminates with the done keyword.

The select loop is used to provide a prompt and a menu of numbered items from which the user inputs a selection. The input will be stored in the special built-in REPLY variable. The select loop is normally used with the case command.

The loop control commands are break and continue. The break command allows control to exit the loop before reaching the end of it, and the continue command allows control to return to the looping expression before reaching the end.

EXAMPLE

while command                                until
ccc.gif command
               do                                           do
               block of statements                         
               ccc.gif block of statements
               done                                         done
               -------------------------                   
               ccc.gif ---------------------------
               while [[ string expression ]]                until
               ccc.gif [[ string expression ]]
               do                                           do
               block of statements                       block
               ccc.gif of statements
               done                                         done
               -------------------------                   
               ccc.gif ----------------------------
               while (( numeric expression ))               until
               ccc.gif (( numeric expression ))
               do                                           do
               block of statements                         
               ccc.gif block of statements
               done                                         done
               
               for variable in word_list                   
               ccc.gif select variable in word_list
               do                                           do
               block of statements                       block
               ccc.gif of statements
               done                                         done
               --------------------------                  
               ccc.gif ----------------------------
               for color in red green b                    
               ccc.gif PS3="Select an item from the menu"
               do                                           do
               ccc.gif item in blue red green
               echo $color                               echo
               ccc.gif $item
               done                                         done
Shows menu:

blue

red

green

Functions

Functions allow you to define a section of shell code and give it a name. There are two formats, one from the Bourne shell, and the Bash version that uses the function keyword.

EXAMPLE

function_name() {
   block of code
}

function  function_name {
   block of code
}
------------------------
function  lister {
   echo Your present working directory is `pwd`
   echo Your files are:
   ls
}
2.6.1 T
