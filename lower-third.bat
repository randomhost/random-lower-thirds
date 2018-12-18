@echo off
set srcFile=lower-third-lines.txt
set destFile=lower-third.txt

randline %srcFile% > %destFile%
