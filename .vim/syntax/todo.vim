if exists("b:current_syntax")
    finish
endif


" Keywords that we want to emphasize
syntax keyword todoKeyword todo done
syntax keyword todoKeyword vrij free
highlight link todoKeyword Keyword


" Remarks about the day
syntax match todoDayKeyword "thuiswerken"
syntax match todoDayKeyword "papadag"
syntax match todoDayKeyword "vrije dag"
syntax match todoDayKeyword "koningsdag"
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
syntax match todoStatusDone "\v^v "
syntax match todoStatusDone "\v v "
syntax match todoStatusDone "\v^x "
syntax match todoStatusDone "\v x "
highlight todoStatusDone ctermfg=green guifg=#00ff00

syntax match todoStatusDoing "\v^d .*$"
syntax match todoStatusDoing "\v d .*$"
highlight todoStatusDoing ctermfg=223 guifg=#f0dfaf

syntax match todoStatusTest "\v^t "
syntax match todoStatusTest "\v t "
highlight todoStatusTest ctermfg=darkcyan guifg=#6666ff

syntax match todoStatusTodo "\v^- "
syntax match todoStatusTodo "\v - "
highlight todoStatusTodo ctermfg=red guifg=#ff0000

syntax match todoStatusQuestion "\v^\? "
syntax match todoStatusQuestion "\v \? "
highlight todoStatusQuestion ctermfg=darkcyan guifg=#6666ff

syntax match note "\v^n .*$"
syntax match note "\v n .*$"
highlight note ctermfg=Grey guifg=#eeeeee

highlight link todoStatusDone PreProc
highlight link todoStatusDoing PreProc
highlight link todoStatusTodo PreProc
highlight link todoStatusQuestion PreProc


" Syntax highlighting scheme name
let b:current_syntax = "todo"
