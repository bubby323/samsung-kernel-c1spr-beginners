#!/bin/bash

# Prompt the user to enter there password so they know that's what they need to do.
echo Enter your password so we can install the required files to compile.

# Request the files we want to install so that we can compile.
sudo apt-get install ia32-libs

# Move on to the next script which will compile the kernel but prompt the user before hand.
echo Now we can compile the kernel...
echo Changing scripts to ./build.sh and compiling the kernel for the first time...
echo This may take a bit..

# Load build.sh and run the commands included in there.
./build.sh

