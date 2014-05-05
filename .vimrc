" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-pathogen'
Plugin 'mhinz/vim-signify'
Plugin 'jnurmine/Zenburn.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


set number
syntax on
" enable words completion
set dictionary+=/usr/share/dict/words
" use ctrl-n ctrl-n instead of ctrl-x ctrl-k
set complete-=k complete+=k

" 2006-04-24
set smartcase

" 2008-04-14 with the if-statement added at 2008-11-19
if &term == "xterm" || &term == "screen-bce"
	set t_Co=256
	colorscheme zenburn

	" create a bar for airline
	set laststatus=2
	let g:airline_powerline_fonts = 1 
endif

" paste and autoindent
set pastetoggle=<F10>
