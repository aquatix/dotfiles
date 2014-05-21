" 2014-02-27 force certain files to be highlighted with Markdown syntax
augroup filetypedetect
    autocmd BufNew,BufNewFile,BufRead *.txt,*.text,*.md,*.markdown :setfiletype markdown
augroup END
" 2014-02-28 this really fixes the filetype recognition
autocmd BufWinEnter *.{md,mkd,mkdn,mark*} silent setf markdown
