" ~/.vimrc VIM configuration file
" Creator: Michiel Scholten
" I try to comment everything, so you know what and why to copy parts. Copying
" wholesale is generally not a good idea; getting an idea to what things
" actually mean and are used for is really recommended.

set shell=/bin/bash

set encoding=utf-8

" change the <Leader> key from \ to ,
let mapleader=","


" == Vundle manages the plugins ================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" == Window chrome =============================================================

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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Better showing of open buffers (open files)
Plugin 'bling/vim-bufferline'
" Version control notes in the line number bar
Plugin 'mhinz/vim-signify'


" Git wrapper
Plugin 'tpope/vim-fugitive'
" fugitive git bindings
" borrowed from https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>


" Better matching of code pairs
"Plugin 'andymass/vim-matchup'
" Deferred highlighting improves cursor movement performance
"let g:matchup_matchparen_deferred = 1


" Think of sensible.vim as one step above 'nocompatible' mode: a universal
" set of defaults that (hopefully) everyone can agree on.
Plugin 'tpope/vim-sensible'
" Nice colour scheme
Plugin 'fenetikm/falcon'
" Quick file system tree, mapped to Ctrl+n for quick toggle
Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', 'tags']
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Easily change position of windows
"<c-w>gh: soft move left
"<c-w>gj: soft move down
"<c-w>gk: soft move up
"<c-w>gl: soft move right
Plugin 'andymass/vim-tradewinds'


" Rooter changes the working directory to the project root when you open a
" file or directory. Useful when using fzf for example.
Plugin 'airblade/vim-rooter'
" Do not echo the project directory
let g:rooter_silent_chdir = 1


" Full path fuzzy file, buffer, mru, tag, ... finder
" Quickly open files, fuzzy search on name
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
" Search in Files, Buffers and MRU files at the same time:
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" Run your favorite search tool from Vim, with an enhanced results list.
" Supports Silver Searcher `ag`. Use with:
" :Ack [options] {pattern} [{directories}]
Plugin 'mileszs/ack.vim'
" apt install silversearcher-ag
if executable('ag')
    "let g:ackprg = 'ag --nogroup --nocolor --column'
    let g:ackprg = 'ag --vimgrep'
endif
" https://github.com/BurntSushi/ripgrep/releases
if executable('rg')
"    let g:ackprg = 'rg --vimgrep'
    set grepprg=rg\ --vimgrep
endif

" fzf integration for fast fuzzy finding, better and faster than ctrl-p
set rtp+=~/workspace/projects/others/fzf
Plugin 'junegunn/fzf.vim'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" :Find term where term is the string you want to search, this will open up a
" window similar to :Files but will only list files that contain the term
" searched
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!**.git/*" --glob "!*.swp" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Simply type ; to search through buffers, leader-o to search through file
" names, \t for tags, \c for (Git) commits and \f to search through contents
" of files
nmap ; :Buffers<CR>
nmap <Leader>o :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>c :Commits<CR>
nmap <Leader>f :Find<CR>
nmap <Leader>l :Lines<CR>

nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>

" Web Development/Filetype icons
" Needs a font like found at
" https://github.com/ryanoasis/nerd-fonts
Plugin 'ryanoasis/vim-devicons'
" Set guifont when using gvim:
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

"
" undotree.vim : Display your undo history in a graph.
Plugin 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1 " if undotree is opened, it is likely one
                                    " wants to interact with it.


" == Content convenience =======================================================

" transparent editing of gpg encrypted files. The filename must have a .gpg,
" .pgp or .asc suffix.
Plugin 'jamessan/vim-gnupg'

" tcomment provides easy to use, file-type sensible comments for Vim. It
" can handle embedded syntax.
Plugin 'tomtom/tcomment_vim'

" Typescript syntax file and more
Plugin 'leafgarland/typescript-vim'
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" handling column separated data (csv)
Plugin 'chrisbra/csv.vim'
autocmd BufNewFile,BufRead *.csv setlocal filetype=csv

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
" On a machine with a Python3-only vim, use system packages like:
" python-jedi python3-jedi to keep jedi working for Python 2 and 3.
" Also, vim-nox-py2 might be needed
Plugin 'davidhalter/jedi-vim'
"let g:jedi#force_py_version = 2

" For example in termux, ycm does not want to compile, don't load it there
" with ~/.dot_no_ycm
let skip_ycm=fnamemodify(expand("$MYVIMRC"), ":p:h") . "/.dot_no_ycm"
if !filereadable(skip_ycm)  " Only load YouCompleteMe if ~/.dot_no_ycm does not exist
" code-completion engine
" sudo apt-get install build-essential cmake
" sudo apt-get install python-dev
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py  # For C-style languages: ./install.py --clang-completer
Plugin 'Valloric/YouCompleteMe'
" YouCompleteMe interpreter version (should be the same as what YCM was
" compiled with):
"let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
" Debug stuff
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
endif


" Improved Django handling
Plugin 'tweekmonster/django-plus.vim'


" Code checker. For python, install flake8 or pylint, preferably in the
" virtualenv. For Django support, install pylint-django
Plugin 'w0rp/ale'
nmap <leader>= <Plug>(ale_fix)
" Quickly open the loclist to see syntax errors
nmap <leader>; :lopen<CR>
let g:ale_maximum_file_size = 500000  " Don't lint large files (> 500KB), it can slow things down
let g:ale_fixers = {}
" Python specific settings
let g:ale_fixers.python = ['isort']
" No silly 80-char line limit. Sorry pep-8. Also, Django support. Disable 'invalid name', 'missing docstring'
if exists('b:is_django')
    let g:ale_python_pylint_options="--max-line-length=120 --load-plugins pylint_django --disable=invalid-name,missing-docstring"
else
    let g:ale_python_pylint_options="--max-line-length=120 --disable=invalid-name,missing-docstring"
endif
" Show errors or warnings in the statusline
let g:airline#extensions#ale#enabled = 1
" UI
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '>'


" Handy Markdown stuff
"Plugin 'tpope/vim-markdown'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Do not fold markdown files by default
let g:vim_markdown_folding_disabled = 1
set nofoldenable
" Use filetype name as fenced code block languages for syntax highlighting
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'python=python']

if v:version >= 704
    " Pandoc, for stuff like autocompletion of citations from bibtex, other LaTeX
    " stuff. Works with vim >= 7.4
    Plugin 'vim-pandoc/vim-pandoc'
endif


" == Writing prose =============================================================

" Distraction-free writing, start with <Leader>V (\V or ,V in this config)
Plugin 'junegunn/goyo.vim'
let g:goyo_width = 120

" Help focus on text by dimming other parts a bit
Plugin 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 'Grey69'
let g:limelight_conceal_ctermfg = 145

" Helps with writing prose (better line breaks, agnostic on soft line wraps vs
" hard line breaks etc)
Plugin 'reedes/vim-pencil'
" Disable automatic formatting, as this automatically merges lines devided by
" 1 hard enter only, which can be annoying
let g:pencil#autoformat = 0

" Do not insert hard line breaks in the middle of a sentence
let g:pencil#wrapModeDefault = 'soft'  " default is 'hard'

" Toggle Gogo with Limelight and Pencil together with Ctrl+F11
"map <C-F11> :Goyo <bar> :Limelight!! <bar> :TogglePencil <CR>
nmap <leader>V :Goyo <bar> :Limelight!! <bar> :TogglePencil <CR>


" The NERD Commenter: A plugin that allows for easy commenting of code for
" many filetypes.
Plugin 'scrooloose/nerdcommenter'

" Highlight colours in CSS (and html) files
Plugin 'ap/vim-css-color'

" Highlight colours in fish shell files
Plugin 'dag/vim-fish'

" Highlight colours in jade/pug templates
Plugin 'digitaltoad/vim-pug'

" Highlight nginx
Plugin 'chr4/nginx.vim'

" Highlight jinja templates (e.g., .j2 files) and do proper indenting
Plugin 'lepture/vim-jinja'
au BufNewFile,BufRead *.j2 set ft=jinja

" Highlight special comments better
Plugin 'jbgutierrez/vim-better-comments'

" CSV filetype plugin
"Plugin 'chrisbra/csv.vim'  " apparently doesn't work this way ;)

" Automatic generation of tags file (ctags), in a central place (~/.vimtags)
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
" easytags highlighting is slow
"let g:easytags_auto_highlight = 0

" Automatic generation of tags file (ctags: Exhuberant Ctags)
Plugin 'ludovicchabant/vim-gutentags'
" know when Gutentags is generating tags (prints 'TAGS' in status-line)
set statusline+=%{gutentags#statusline()}
let g:gutentags_ctags_exclude = ["*.min.*", "build", ".bundle", ".git", "log", "node_modules", "tmp", "vendor", "*.vim/bundle/*"]
"let g:gutentags_trace = 1


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" == End of plugins ============================================================


"filetype plugin on

" Enable line numbers, highlighting of current line and syntax highlighting by default
set number
set cursorline
syntax on

if has('patch-7.4-338')
    " automatically indents wrapped lines up to the previous line. You can also
    " use the showbreak option to automatically indent the line even more
    set breakindent
endif

" Show tabs and trailspaces
set listchars=tab:▸\ ,trail:·
" Display whitespace
set list

" enable words completion
set dictionary+=/usr/share/dict/words
" use ctrl-n ctrl-n instead of ctrl-x ctrl-k
set complete-=k complete+=k
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

" use a decent crypto method
set cryptmethod=blowfish2

" Ensure 256 colour support if the terminal supports it
if &term == "xterm" || &term == "xterm-256color" || &term == "screen-bce" || &term == "screen-256color" || &term == "screen" || &term == "tmux-256color-italic"
    colorscheme falcon

    " create a bar for airline
    set laststatus=2
    let g:airline_powerline_fonts = 1
endif

" This is what sets vim to use 24-bit colors. It will also work for any version of neovim
" newer than 0.1.4.
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Toggle paste and autoindent mode (enable paste so no indention weirdness
" happens when pasting into the current file)
set pastetoggle=<F10>

" Tab navigation
nmap <c-Up> :tabnew<CR>
nmap <c-Right> :tabnext<CR>
nmap <c-Left> :tabprevious<CR>

" Prettify json and javascript
map <Leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

" Replace 'dayh' with a formatted day header
iab <expr> dayh strftime("== %Y%m%d %A ======")
" Replace 'timeh' with a formatted date/time header
iab <expr> timeh strftime("## %Y%m%d %a %H:%M:%S")

" Fly through buffers instead of cycling
" nnoremap <leader>l :ls<cr>:b<space>

" Close Location windows, if exist, switch to the previous view buffer, and then close the last switched buffer.
nnoremap <silent> <leader>q :lclose<bar>b#<bar>bd #<CR>

" Git and Mercurial 'blame' command. First select lines in visual modes, then
" hit the appropriate leader key sequence (e.g., \g for git blame)
" Update: For Git blame, just do :Gblame from vim-fugitive
"vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
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

" Italics
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"
