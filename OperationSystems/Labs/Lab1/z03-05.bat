@echo off
echo Parameters: %*
echo Parameter 1: %1
echo Parameter 2: %2
echo Parameter 3: %3
set /a res = %1 %3 %2
echo %res%
