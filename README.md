<img src="./assets/bird_dark.svg" height="250" align="left"></img>

# Bird
![Discord](https://img.shields.io/discord/491348922367868938.svg?label=Discord) ![GitHub](https://img.shields.io/github/license/eliassjogreen/Bird.svg) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/eliassjogreen/Bird.svg)
> **Bird** = **B**atch **i**s **r**eally **b**ad  
> Not that a language written in it is any better 

*Bird* is a toy programming language written entirely in Microsoft's batch scripting language. It adds amazing features such as [functions](examples/Function.bird) and [importing libraries](examples/HelloWorld.bird) like any other programming language at the cost of stuff like arithmetic and if statements.

## Features
* Functions with parameters
* Importing libraries
* Compilation to batch

## Examples
### [HelloWorld.bird](examples/HelloWorld.bird):
```
use std

define Main
    Println "Hello World"
end

# Prints "Hello World"
```
### [Function.bird](examples/Function.bird):
```
use std

define Main $name
    Println Hello $name
end

define Hello $name
    return "Hello " $name
end

#  Prints 'Hello ' + your first command line parameter
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
```

## TODO
- [ ] Arithmetic
- [ ] Loops
- [ ] If-statements
- [ ] Expand std

<sub><sup>Batch is pain. Batch is pain. Batch is pain.</sup></sub>