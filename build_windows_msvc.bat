@echo off

cl /c /Z7 /DDEBUG nuklear.c
lib /OUT:nuklear_windows_amd64_debug.lib nuklear.obj
del nuklear.obj

cl /c /O2 nuklear.c
lib /OUT:nuklear_windows_amd64_release.lib nuklear.obj
del nuklear.obj
