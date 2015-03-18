if exists("b:current_syntax")
    finish
endif

syntax keyword todoKeyword todo done
highlight link todoKeyword Keyword

let b:current_syntax = "todo"
