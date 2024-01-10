highlight TestOk    ctermfg=lightgreen 
highlight TestInfo    ctermfg=yellow
highlight TestWarning    ctermfg=green
highlight TestError ctermfg=darkred

syn match TestOk    ".*\[Finished.*"
syn match TestInfo    ".*===.*"
syn match TestError  ".*\\033\[0;31m.*\[0m"
syn match TestWarning  ".*\\033\[0;33m.*\[0m"
syn match TestInfo  ".*\\033\[0;34m.*\[0m"
syn match TestOK  ".*\\033\[0;32m.*\[0m"
syn match TestInfo    ".*INFO.*"
syn match TestInfo    ".*Info.*"
syn match TestWarning    ".*WARNING.*"
syn match TestWarning    ".*Warning.*"
syn match TestError    ".*Error.*"
syn match TestError    ".*Err.*"
syn match TestError    ".*ERROR.*"


