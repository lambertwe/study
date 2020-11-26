@echo off
set "ori=%cd%"
cd..
set "bbd=%cd%"
echo ‘À––docs£¨web∑√Œ http://localhost:3000
cmd /k "cd /d %bbd%&&docsify serve docs"