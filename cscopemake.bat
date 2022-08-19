
set SRC_PATH=%1
set CSCOPE_PATH=~\cscope\%2
mkdir ~\cscope\%2
cd /d %CSCOPE_PATH%
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "Get-ChildItem %SRC_PATH% -recurse -include (*.h,*.c,*.hpp,*.cpp,*.md,CmakeList.txt) | ForEach-Object { $_.FullName } | Out-file cscope.files -encoding utf8"
C:\Users\yuanhu1\Downloads\program\Vim\vim81\cscope.exe -bkq -i .\cscope.files

