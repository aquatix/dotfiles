if exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim
unlet! b:current_syntax

"runtime! syntax/markdown.vim
"unlet! b:current_syntax

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
syntax region todoDay start=/\v\=\=\ / skip=/\v\\./ end=/\v\ \=\=\=\=\=\=/

highlight link todoDay Delimiter


" Show -scratched out- parts of a line as darker text (Delimiter colour)
syntax region scratchThis start=/\v --/ skip=/\v\\./ end=/\v--\ / oneline

highlight scratchThis ctermfg=Grey guifg=#666666


" Task statuses
syntax match todoNote "\v^\s{-}n .*$" nextgroup=todoNote
syntax match todoNote "\v^  .*$" nextgroup=todoNote
highlight todoNote ctermfg=Grey guifg=#666666

syntax match todoStatusDone "\v^\s{-}v " nextgroup=todoItem skipwhite
highlight todoStatusDone ctermfg=green guifg=#00ff00

syntax match todoStatusCancelled "\v^\s{-}x .*$" nextgroup=todoItem skipwhite
highlight todoStatusCancelled ctermfg=DarkGreen guifg=#005f00

syntax match todoStatusDoing "\v^\s{-}d .*$" nextgroup=todoItem skipwhite
highlight todoStatusDoing ctermfg=223 guifg=#f0dfaf

syntax match todoStatusTest "\v^\s{-}t " nextgroup=todoItem skipwhite
highlight todoStatusTest ctermfg=darkcyan guifg=#6666ff

syntax match todoStatusTodo "\v^\s{-}- " nextgroup=todoItem skipwhite
highlight todoStatusTodo ctermfg=red guifg=#ff0000

syntax match todoStatusImportant "\v^\s{-}\> .*$" nextgroup=todoItem skipwhite
syntax match todoStatusImportant "\v^\s{-}! .*$" nextgroup=todoItem skipwhite
highlight todoStatusImportant ctermfg=167 guifg=#d75f5f

syntax match todoStatusQuestion "\v^\s{-}\? " nextgroup=todoItem skipwhite
highlight todoStatusQuestion ctermfg=darkcyan guifg=#6666ff

" Highlight matching brackets (for example a timeslot)
"syntax match brack /[\[\]]/ | hi brack ctermfg=DarkMagenta

syntax match timeslot "\v\[.*-.*\] " nextgroup=todoItem skipwhite
highlight timeslot ctermfg=Magenta guifg=#d700af

" Match items starting with a <keyword-or-date-or-something>:
syntax match todoTitledItem /^[a-zA-Z0-9\-_]*: / nextgroup=todoItem skipwhite
highlight todoTitledItem ctermfg=172 guifg=#d78700
"highlight todoTitledItem ctermfg=130 guifg=#af5f00  " DarkOrange

" A todoItem has a subject (e.g., a word that's followed by a ':')
syntax match todoItem '[a-zA-Z0-9\-_]\+:' contained
highlight todoItem ctermfg=Blue guifg=#87d7ff


syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=markdownUrl skipwhite
syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained
syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

highlight link todoStatusDone PreProc
highlight link todoStatusDoing PreProc
highlight link todoStatusCancelled PreProc
highlight link todoStatusTest PreProc
highlight link todoStatusTodo PreProc
highlight link todoStatusImportant PreProc
highlight link todoStatusQuestion PreProc

hi def link markdownLinkText              htmlLink
hi def link markdownIdDeclaration         Typedef
hi def link markdownId                    Type
hi def link markdownAutomaticLink         markdownUrl
hi def link markdownUrl                   Float
hi def link markdownUrlTitle              String
hi def link markdownIdDelimiter           markdownLinkDelimiter
hi def link markdownUrlDelimiter          htmlTag
hi def link markdownUrlTitleDelimiter     Delimiter

" runtime! syntax/markdown.vim
" unlet! b:current_syntax

" Syntax highlighting scheme name
let b:current_syntax = "todo"
