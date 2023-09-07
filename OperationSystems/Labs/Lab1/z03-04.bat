@echo off
echo --Parameter 1: %1
echo --Parameter 2: %2
echo --Parameter 3: %3
set /A a = %1
set /A b = %2
set /A c = %3
set /A sum = a + b
set /A sub = a * b
set /A div = c / a
set /A part1 = b - a
set /A part2 = a - b
set /A prob = part1 * part2
echo %a% + %b% = %sum%
echo %a% * %b% = %sub%
echo %c% / %a% = %div%
echo (%b% - %a%) * (%a% - %b%) = %prob%
pause