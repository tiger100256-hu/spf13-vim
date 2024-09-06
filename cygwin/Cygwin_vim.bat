@echo off
setlocal enableextensions ENABLEDELAYEDEXPANSION
set TERM=
cd /d "%~dp0bin" && .\bash --login -i -c "cd; export DISPLAY=:0.0; gvim --remote-tab-silent \"$(cygpath -u '%~1')\"" 