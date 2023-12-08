@echo off

REM Run ANTLR4 Parser Generator
java -classpath lib\antlr-4.13.1-complete.jar;. org.antlr.v4.Tool -Xlog %*