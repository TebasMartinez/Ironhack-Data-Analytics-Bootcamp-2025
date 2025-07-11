# Week 01 - Python Fundamentals

## Index
- Data Structures
- Flow control
- Functions
- List/Dict/Set Comprehension
- Lambda functions
- Error handling

## Notes

- Libraries are collections of code used for a specific purpose.
- Python is a high level language, as opposed to low level languages like C (which are more complex and "give more detailed instructions" to the computer). Python abstracts a lot of the complexities.

### Data types
- Integer
- Float
- String
- Bool: True (1) or

#### Arithmetic Operators
+, -, *, etc etc

Use module operator (%) to find evens/odds: if it returns 0 it's even, otherwise odd.

#### Assignment Operators
=

+=

-=

*=

etc

#### Comparison Operators
Return boolean result: ==, !=, >, <, <=, >=

#### Logical Operators
and, or, not

#### Data Type Compatibility and Casting
int(), float(), str(), bool()

### String methods and functions

#### Data structures
- Lists
- Dictionaries
- Sets
- Tuples

### Flow control

#### Conditional Statements.
if, elif, else

### Functions
We can create a docstring, a description to our user-defined function, with triple quotes:

````
def square(number):
    """Calculate the square of a number."""
    result = number ** 2
    return result
````

### Lambda functions
They are used in higher level functions. \
A higher level function takes as input a function and an iterable. It uses the function on the iterable. \ 

The filter function only takes funcions that return a boolean value.
