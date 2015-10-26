" ~/.vimrc VIM configuration file
" Creator: Michiel Scholten
" I try to comment everything, so you know what and why to copy parts. Copying
" wholesale is generally not a good idea; getting an idea to what things
" actually mean and are used for is really recommended.

" Vundle manages the plugins
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
"Plugin 'Shougo/unite.vim'
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>r :<C-u>Unite -start-insert file_rec<CR>

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
let NERDTreeIgnore = ['\.pyc$']
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Full path fuzzy file, buffer, mru, tag, ... finder
" Quickly open files, fuzzy search on name
Plugin 'kien/ctrlp.vim'
"let g:ctrlp_map = '<Leader>t'
let g:ctrlp_map = '<c-p>'
" Search in Files, Buffers and MRU files at the same time:
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0


" Web Development/Filetype icons
" Needs a font like found at
" https://github.com/ryanoasis/nerd-fonts
Plugin 'ryanoasis/vim-devicons'
" Set guifont when using gvim:
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11


" == Content convenience ======

" Automatically insert matching close bracket where it belongs
"Plugin 'seletskiy/vim-autosurround'
"inoremap  ( (<C-O>:call AutoSurround(")")<CR>

" Spell Check (http://vim.wikia.com/wiki/Toggle_spellcheck_with_function_keys)
" Loop through various languages to select the one to spellcheck with
let b:myLang=0
let g:myLangList=["nospell","nl","en_gb","en_us"]
function! ToggleSpell()
  if !exists( "b:myLang" )
    let b:myLang=0
  endif
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

" Map <F7> to toggle the language with
nmap <silent> <F7> :call ToggleSpell()<CR>

" In case the spelling language was set by other means than ToggleSpell() (a filetype autocommand say):
if !exists( "b:myLang" )
  if &spell
    let b:myLang=index(g:myLangList, &spelllang)
  else
    let b:myLang=0
  endif
endif

" Word completion from dictionary (on ctrl+space)
set complete+=kspell

" Python virtualenv support
"Plugin 'jmcantrell/vim-virtualenv'

" Python goodness
"Plugin 'klen/python-mode'

" Python autocompletion
Plugin 'davidhalter/jedi-vim'


" Code checker. For python, install flake8 or pylint, preferably in the
" virtualenv. For Django support, install pylint-django
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" No silly 80-char line limit. Sorry pep-8. Also, Django support. Disable 'invalid name', 'missing docstring'
let g:syntastic_python_pylint_post_args="--max-line-length=120 --load-plugins pylint_django -d C0103,C0111"

" Use the virtualenv's Python interpreter
"if $VIRTUAL_ENV != ''
"    let g:syntastic_python_python_exec = '$VIRTUAL_ENV/bin/python'
"endif

"let g:syntastic_python_checkers=['pylint']
"let g:syntastic_python_python_exec = 'python'
"let g:syntastic_python_pylint_exe = 'python -m pylint'
"let g:syntastic_python_pylint_exe = 'python $(which pylint)'


" Handy Markdown stuff
Plugin 'tpope/vim-markdown'
if v:version >= 704
    " Pandoc, for stuff like autocompletion of citations from bibtex, other LaTeX
    " stuff. Works with vim >= 7.4
    Plugin 'vim-pandoc/vim-pandoc'
endif

" Distraction-free writing, start with <Leader>V (\V or ,V in this config)
Plugin 'mikewest/vimroom'

" undotree.vim : Display your undo history in a graph.
Plugin 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1 " if undotree is opened, it is likely one
                                    " wants to interact with it.

" The NERD Commenter: A plugin that allows for easy commenting of code for
" many filetypes.
Plugin 'scrooloose/nerdcommenter'

" Highlight colours in CSS (and html) files
Plugin 'ap/vim-css-color'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Enable line numbers, highlighting of current line and syntax highlighting by default
set number
set cursorline
syntax on

" Show tabs and trailspaces
set listchars=tab:▸\ ,trail:·
" Display whitespace
set list

" enable words completion
set dictionary+=/usr/share/dict/words
" use ctrl-n ctrl-n instead of ctrl-x ctrl-k
set complete-=k complete+=k
" change the <Leader> key from \ to ,
let mapleader=","
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ctags: check the current folder for tags file and keep going one directory up
" all the way to the homedir
set tags=./tags,./TAGS,tags;~,TAGS;~

" ignorecase plus smartcase make searches case-insensitive except when you
" include upper-case characters (so /foo matches FOO and fOo, but /FOO only
" matches the former)
set ignorecase
set smartcase

" reload file when changes happen in other editors
set autoread

" hide buffers instead of closing them (so no saving is needed and undo and
" marks are preserved)
set hidden

" Ensure 256 colour support if the terminal supports it
if &term == "xterm" || &term == "xterm-256color" || &term == "screen-bce" || &term == "screen-256color" || &term == "screen"
	set t_Co=256
	colorscheme zenburn

	" create a bar for airline
	set laststatus=2
	let g:airline_powerline_fonts = 1
endif

" Toggle paste and autoindent mode (enable paste so no indention weirdness
" happens when pasting into the current file)
set pastetoggle=<F10>

" Prettify json and javascript
map <Leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

" Replace 'dayh' with a formatted day header
iab <expr> dayh strftime("== %Y%m%d %A ======")

" Fly through buffers instead of cycling
nnoremap <leader>l :ls<cr>:b<space>

" Git and Mercurial 'blame' command. First select lines in visual modes, then
" hit the appropriate leader key sequence (e.g., \g for git blame)
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>


" Enables input of special characters by a combination of two characters.
" Example: Type 'a', erase it by typing CTRL-H - and then type ':' - this
" results in the umlaut: ä So Vim remembers the character you have erased and
" combines it with the character you have typed "over" the previous one.
"set digraph
" Disabled as it also works with backspace and gives odd results with some
" normal typing, giving asiatic glyphs and such. Just use CTRL+k a:

" Number of visual spaces per TAB
set tabstop=4
" Number of spaces in tab when editing
set softtabstop=4
" Turn tabs into spaces
set expandtab
" How many columns text is indented with the reindent operations and automatic
" indentation
set shiftwidth=4
" Indentation according to shiftwidth when <TAB> is pressed at beginning of line
set smarttab
" Indentation setting for everywhere else (not beginning of line)
set softtabstop=4
" Copy the indentation of the previous line
set autoindent

" Django html template highlighting by default
au BufNewFile,BufRead *.html set filetype=htmldjango
