@echo off

cl nuklear.c /Fe:assertions /DASSERTIONS
assertions.exe
del nuklear.obj
del assertions.exe

