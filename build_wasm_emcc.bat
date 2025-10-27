@echo off

call emcc -c -g -DDEBUG nuklear.c -o nukler_wasm_debug.o
call emcc -c -O2 nuklear.c -o nukler_wasm_release.o
