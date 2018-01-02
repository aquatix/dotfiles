if exists("b:current_syntax")
    finish
endif


" Keywords that we want to emphasize
"syntax keyword todoKeyword todo done important
"syntax keyword todoKeyword whoa free
"highlight link todoKeyword Keyword


" Remarks about the day
syntax match todoDayKeyword "thuiswerken"
syntax match todoDayKeyword "Thuis"
syntax match todoDayKeyword "Thuiswerken"
syntax match todoDayKeyword "Hackathon"
syntax match todoDayKeyword "hackathon"
syntax match todoDayKeyword "papadag"
syntax match todoDayKeyword "vrije dag"
syntax match todoDayKeyword "vrij"
syntax match todoDayKeyword "Vrij"
syntax match todoDayKeyword "koningsdag"
"syntax match todoDayKeyword "ill"
syntax match todoDayKeyword "ziek"
syntax match todoDayKeyword "ziekig"
highlight todoDayKeyword ctermfg=116 guifg=#8cd0d3


" Inline commenting
syntax match todoComment "\v#.*$"
highlight link todoComment Comment


" Heading (day) delimiters
syn region todoDay matchgroup=todoHeadingDelimiter start="==\@!" end="==*\s*$" keepend oneline

hi def link todoHeadingDelimiter Delimiter


" Generic operators
syntax match todoOperator "\v\*"
syntax match todoOperator "\v/"
syntax match todoOperator "\v\+"
syntax match todoOperator "\v-"

highlight link todoOperator Operator


" Task statuses
syntax match note "\v^n .*$"
syntax match note "\v n .*$"
syntax match note "\v  .*$"
highlight note ctermfg=Grey guifg=#eeeeee

syntax match todoStatusDone "\v^v "
syntax match todoStatusDone "\v  v "
syntax match todoStatusDone "\v^x "
syntax match todoStatusDone "\v  x "
highlight todoStatusDone ctermfg=green guifg=#00ff00

syntax match todoStatusDoing "\v^d .*$"
syntax match todoStatusDoing "\v  d .*$"
highlight todoStatusDoing ctermfg=223 guifg=#f0dfaf

syntax match todoStatusTest "\v^t "
syntax match todoStatusTest "\v  t "
highlight todoStatusTest ctermfg=darkcyan guifg=#6666ff

syntax match todoStatusTodo "\v^- "
syntax match todoStatusTodo "\v  - "
highlight todoStatusTodo ctermfg=red guifg=#ff0000

syntax match todoStatusImportant "\v^\> .*$"
syntax match todoStatusImportant "\v  \> .*$"
syntax match todoStatusImportant "\v^! .*$"
syntax match todoStatusImportant "\v  ! .*$"
"highlight todoStatusImportant ctermfg=131 guifg=#af5f5f
highlight todoStatusImportant ctermfg=167 guifg=#d75f5f

syntax match todoStatusQuestion "\v^\? "
syntax match todoStatusQuestion "\v  \? "
highlight todoStatusQuestion ctermfg=darkcyan guifg=#6666ff

" Highlight matching brackets (for example a timeslot)
"syntax match brack /[\[\]]/ | hi brack ctermfg=DarkMagenta

syntax match timeslot "\v\[.*-.*\] "
highlight timeslot ctermfg=Magenta

highlight link todoStatusDone PreProc
highlight link todoStatusDoing PreProc
highlight link todoStatusTodo PreProc
highlight link todoStatusImportant PreProc
highlight link todoStatusQuestion PreProc


" Syntax highlighting scheme name
let b:current_syntax = "todo"
