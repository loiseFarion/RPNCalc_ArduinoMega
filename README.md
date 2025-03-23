# CALCULATOR PROJECT - PHASE 1 - B

### It is recommended to use Microchip Studio to load the program with the 'pausas.inc' and 'Calculadora.asm' files onto the Arduino Mega, after running the Python program.

Additionally, it generates the 'pausas.inc' and 'Calculadora.asm' files. The .asm file contains the assembly code for performing operations on the Arduino Mega, which uses the .inc file with functionalities to introduce a delay between operations.

This is a Python program developed to solve arithmetic expressions in Reverse Polish Notation (RPN). The program reads expressions from a text file and computes the results. The expressions involve addition, subtraction, multiplication, real division, integer division, integer division remainder, exponentiation, and three special commands: (N RES), (V MEM), and (MEM). The program executes each expression in an online Python environment and generates a 'Calculadora.asm' file, which is used to upload to the Arduino Mega to display the results of the operations in all lines of the input file.

## Operations in RPN Notation
  -> A and B represent real numbers.

  a) Addition: +, in the format (A B +);  <br />
  b) Subtraction: -, in the format (A B -);  <br />
  c) Multiplication: *, in the format (A B *);  <br />
  d) Real Division: |, in the format (A B |);  <br />
  e) Integer Division: /, in the format (A B /);  <br />
  f) Integer Division Remainder: %, in the format (A B %);  <br />
  g) Exponentiation: ^, in the format (A B ^); <br />

### Special Commands
  a) (N RES): Returns the result of the expression that is N lines before, where N is a non-negative integer;  <br />
  b) (V MEM): Stores a value, V, in a memory space called MEM, which can store a real value;  <br />
  c) (MEM): Returns the value stored in memory. If memory has not been used previously, it returns the real number zero. Each text file is a scope of application. <br />

### Additional Requirement Notes
  Use the period to indicate the decimal point. <br />
  The exponent in the exponentiation operation will always be a positive integer. <br />
  The indicated expressions can be nested to create composite expressions. <br />
  The program should be executed by providing the name of the test file as an argument in the command line. <br />
  All operations will be executed on real half-precision numbers (16 bits/IEEE754) <br />

## Running the Program
  To run the program, execute the following:

  --- Replit Shell <br />
    python main.py testFileName <br />

  Replace 'testFileName' with the name of the file you wish to solve.

## Example of Execution
### Text File
  File name: 'calculos' <br />
  Content of the text file:  <br />
  (2 2 +) <br />
  3 (1 2 *) *) <br />
  (16 (2 2 ^) /) <br />
  ((9 5 *) 10 +) <br />
  ((3 2 ^) (2 2 ^) *) <br />
  
### Program Execution
  --- Replit Shell <br />
  python partB.py 'calculos'

### Execution Result
  The results of the expressions contained in the 'calculos.txt' file will be displayed in the online environment in the format '-> expression = X', where 'expression' is the calculation performed and 'X' is the result of the calculation.

  --- Replit <br />
  -> (2 2 +) = 4.0 <br />
  -> (3 (1 2 *) *) = 6.0 <br />
  -> (16 (2 2 ^) /) = 4.0 <br />
  -> ((9 5 *) 10 +) = 55.0 <br />
  -> ((3 2 ^) (2 2 ^) *) = 36.0 <br />
