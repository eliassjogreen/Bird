<img src="./assets/bird_dark.svg" height="250" align="left"></img>

# Bird
> **Bird** = **B**atch **i**s **r**eally **b**ad  
> Not that a language written in it is any better 

*Bird* is a programming language written entirely in Microsoft's batch scripting language. It adds amazing features such as [functions](examples/Function.bird) and [importing libraries](examples/HelloWorld.bird) like any other programming language at the cost of stuff like arithmetic and if statements.

## Features
* Functions with parameters
* Importing libraries
* Compilation to batch

## Examples
### [HelloWorld.bird](examples/HelloWorld.bird):
```
use std

define Main
    Println Hello World
end

# Prints "Hello World"
```
### [Function.bird](examples/Function.bird):
```
use std

define Main $name
    Hello $name
end

define Hello $name
    Println Hello $name
end

# Prints "Hello <input>"
```

## Usage
Clone or download this repo and then enter the new folder
```console
$ git clone https://github.com/eliassjogreen/bird
$ cd .\bird-master\
```
Then build the libraries in the `.\lib\` folder
```console
$ .\build.bat
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
* Arithmetic
* Loops
* If-statements
* Expand std

<sub><sup>Batch is pain. Batch is pain. Batch is pain.</sup></sub>