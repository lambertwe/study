@echo off
set "ori=%cd%"
cd..
set "bbd=%cd%"
echo ����docs��web����http://localhost:3000
cmd /k "cd /d %bbd%&&docsify serve docs"