if exists("b:current_syntax")
    finish
endif

syntax keyword todoKeyword todo done
syntax keyword todoKeyword vrij free
highlight link todoKeyword Keyword

syntax match todoComment "\v#.*$"
highlight link todoComment Comment

syn region todoDay matchgroup=todoHeadingDelimiter start="==\@!" end="==*\s*$" keepend oneline

hi def link todoHeadingDelimiter Delimiter

let b:current_syntax = "todo"
