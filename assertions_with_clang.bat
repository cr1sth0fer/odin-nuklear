@echo off

clang nuklear.c -std=c99 -o assertions.exe -DASSERTIONS
assertions.exe
del assertions.exe