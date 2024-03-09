@echo off

cl /c /O2 nuklear.c
lib /OUT:nuklear_windows_amd64.lib nuklear.obj
del nuklear.obj