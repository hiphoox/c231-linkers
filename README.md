# c231-linkers

**Compilers Project Elixir , Linkers Team**

## Instalation

First you need the last version of elixir then you can follow the next instructions

1) git clone https://github.com/hiphoox/c231-linkers
2) cd c231-linkers (check the path where you clone the repository)
3) mix escript.build

## Usasge

You can use the following args to use the compiler

`./nqcc (path of the .c)`

**Flags**

`./nqcc --help` :print the help

`./nqcc --<flag> (path of the .c)`

`--asm` :Shows file assembler  
`--tl`  :Shows token List  
`--ast` :Shows AST tree  
`--o `  :Change the name of the executable

## Examples

To compile the .c file

`./nqcc ./examples/return_2.c`

To use flags

`./nqcc --help`  
`./nqcc --tl ./examples/return_2.c`  
`./nqcc --o ./examples/return_2.c return`
  
