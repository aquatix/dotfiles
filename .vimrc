" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" == UI ======

" Display tags of the current file ordered by scope
" You need ctags: `sudo apt-get install exuberant-ctags` or
" `brew install ctags` for example
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
" The unite or unite.vim plug-in can search and display information from
" arbitrary sources like files, buffers, recently used files or registers.
Plugin 'Shougo/unite.vim'

" Nice statusbar, alternative for powerline. Get powerline font for best
" looking result
Plugin 'bling/vim-airline'
" Better showing of open buffers (open files)
Plugin 'bling/vim-bufferline'
" Version control notes in the line number bar
Plugin 'mhinz/vim-signify'
" Think of sensible.vim as one step above 'nocompatible' mode: a universal
" set of defaults that (hopefully) everyone can agree on.
Plugin 'tpope/vim-sensible'
" Nice colour scheme
Plugin 'jnurmine/Zenburn.git'
" Quick file system tree, mapped to Ctrl+n for quick toggle
Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Full path fuzzy file, buffer, mru, tag, ... finder
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0


" == Content convenience ======

" Python autocompletion
Plugin 'davidhalter/jedi-vim'
" Handy Markdown stuff
Plugin 'tpope/vim-markdown'
if v:version >= 704
	" Pandoc, for stuff like autocompletion of citations from bibtex, other LaTeX
	" stuff. Works with vim >= 7.4
	Plugin 'vim-pandoc/vim-pandoc'
endif
" Distraction-free writing, start with <Leader>V (\V)
Plugin 'mikewest/vimroom'
" undotree.vim : Display your undo history in a graph.
Plugin 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1 " if undotree is opened, it is likely one
                                    " wants to interact with it.
" The NERD Commenter : A plugin that allows for easy commenting of code for
" many filetypes.
Plugin 'scrooloose/nerdcommenter'

" Highlight colours in CSS files
Plugin 'ap/vim-css-color'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Enable line numbers, highlighting of current line and syntax highlighting by default
set number
set cursorline
syntax on
" enable words completion
set dictionary+=/usr/share/dict/words
" use ctrl-n ctrl-n instead of ctrl-x ctrl-k
set complete-=k complete+=k

" ignorecase plus smartcase make searches case-insensitive except when you
" include upper-case characters (so /foo matches FOO and fOo, but /FOO only
" matches the former)
set ignorecase
" 2006-04-24
set smartcase

" reload file when changes happen in other editors
set autoread

" 2008-04-14 with the if-statement added at 2008-11-19
if &term == "xterm" || &term == "screen-bce" || &term == "screen-256color" || &term == "screen"
	set t_Co=256
	colorscheme zenburn

	" create a bar for airline
	set laststatus=2
	let g:airline_powerline_fonts = 1
endif

" paste and autoindent
set pastetoggle=<F10>

" Prettify json and javascript
map <Leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

" Fly through buffers instead of cycling
nnoremap <leader>l :ls<cr>:b<space>

" 2014-01-29 some sane Python settings
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set smarttab
autocmd FileType python set expandtab
autocmd FileType python set softtabstop=4
autocmd FileType python set autoindent

" 2014-01-29 some sane PHP settings
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set smarttab
autocmd FileType php set expandtab
autocmd FileType php set softtabstop=4
autocmd FileType php set autoindent

" 2014-03-21 some sane LaTeX settings
autocmd FileType tex set tabstop=4
autocmd FileType tex set shiftwidth=4
autocmd FileType tex set smarttab
autocmd FileType tex set expandtab
autocmd FileType tex set softtabstop=4
autocmd FileType tex set autoindent

" 2014-06-24 some sane shell settings
autocmd FileType sh set tabstop=4
autocmd FileType sh set shiftwidth=4
autocmd FileType sh set smarttab
autocmd FileType sh set expandtab
autocmd FileType sh set softtabstop=4
autocmd FileType sh set autoindent

" 2014-10-05 some sane Markdown settings
autocmd FileType markdown set tabstop=4
autocmd FileType markdown set shiftwidth=4
autocmd FileType markdown set smarttab
autocmd FileType markdown set expandtab
autocmd FileType markdown set softtabstop=4
autocmd FileType markdown set autoindent
