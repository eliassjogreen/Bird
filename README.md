<img src="./assets/bird_dark.svg" height="250" align="left"></img>

# Bird
![GitHub](https://img.shields.io/github/license/eliassjogreen/Bird.svg) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/eliassjogreen/Bird.svg)
> **Bird** = **B**atch **i**s **r**eally ba**d**  
> Not that a language written in it is any better 

*Bird* is a toy programming language written entirely in Microsoft's batch scripting language. It adds amazing features such as [functions](examples/Function.bird) and [importing libraries](examples/HelloWorld.bird) like any other programming language at the cost of stuff like arithmetic and if statements.

## Features
* Functions with parameters
* Importing libraries
* Compilation to batch

## Examples
### [HelloWorld.bird](examples/HelloWorld.bird):
```
use Console

define Main
    Console.Println "Hello World"
end

# Prints 'Hello World'
```
### [Function.bird](examples/Function.bird):
```
use Console String Math "Library"

define Main $name
    Console.Println String.Concat "Hello " $name
    Console.Println TimesTwo "16"
    Library.PrintHello
end

define TimesTwo $1
    $out Math.Mul $1 "2"
    return $out
end

# First prints 'Hello ' + your first command line parameter
# Then prints '32'
# And lastly prints 'Hello'
```
### [Math.bird](examples/Math.bird):
```
use Console Math

define Main
    Console.Println Math.Add "1" "2"
    Console.Println Math.Mul "19" "5"
    Console.Println Math.Sub "7" "3"
    Console.Println Math.Div "10" "2"
    Console.Println Math.Mod "20" "5"
end

# Prints:
# 3
# 95
# -3
# 5
# 0
```
### [Prompt.bird](examples/Prompt.bird):
```
use Console String

define Main $name
    $name Console.Prompt "What is your name: "
    Console.Println String.Concat "Hello " $name
end

# Prompts 'What is your name: ' then prints 'Hello <name>'
```

## Usage
Clone or download this repo and then enter the new folder
```console
$ git clone https://github.com/eliassjogreen/Bird.git
$ cd .\bird-master\
```
Then compile the libraries in the `.\lib\` folder
```console
$ .\bird.bat install
```
And you are ready to go! For example:
```console
$ .\bird.bat run .\examples\HelloWorld.bird
Hello World
```
Or:
```console
$ .\bird.bat compile .\examples\Function.bird .\examples\Function.bat
$ .\examples\Function.bat Elias
Hello Elias
32
```

## TODO
- [x] Arithmetic
- [x] Expand std (Added replacing libraries instead of expanding std (std is now removed))
- [ ] Loops
- [ ] If-statements

<sub><sup>Batch is pain. Batch is pain. Batch is pain.</sup></sub>
