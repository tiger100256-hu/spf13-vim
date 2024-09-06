@echo off
setlocal enableextensions
set TERM=
cd /d "%~dp0bin" && .\run.exe --quote /usr/bin/bash.exe -l -c "cd; killall XWin; sleep 3; source ~/.bashrc; exec /usr/bin/startxwin;"
sleep 10s
cd /d "%~dp0bin" && .\run.exe --quote /usr/bin/bash.exe -l -c "cd; export DISPLAY=:0.0; source ~/.bashrc; emacs&" 
sleep 1s
cd /d "%~dp0bin" && .\bash --login -i -c "cd; export DISPLAY=:0.0; source ~/.bashrc; gvim&" 
sleep 1s
cd /d "%~dp0bin" && .\bash --login -i -c "cd; export DISPLAY=:0.0; source ~/.bashrc; ls&" 

