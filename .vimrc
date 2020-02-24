" ~/.vimrc VIM configuration file
" Creator: Michiel Scholten
" I try to comment everything, so you know what and why to copy parts. Copying
" wholesale is generally not a good idea; getting an idea to what things
" actually mean and are used for is really recommended.

set shell=/bin/bash

set encoding=utf-8

" change the <Leader> key from \ to ,
let mapleader=","


" == vim-plug manages the plugins ==============================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')


" == Basics ====================================================================

" Think of sensible.vim as one step above 'nocompatible' mode: a universal
" set of defaults that (hopefully) everyone can agree on.
Plug 'tpope/vim-sensible'


" Rooter changes the working directory to the project root when you open a
" file or directory. Useful when using fzf for example.
Plug 'airblade/vim-rooter'
" Do not echo the project directory
let g:rooter_silent_chdir = 1


" == Window chrome =============================================================

" Display tags of the current file ordered by scope
" You need ctags: `sudo apt-get install exuberant-ctags` or
" `brew install ctags` for example
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Nice statusbar, alternative for powerline. Get powerline font for best
" looking result
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = "hybrid"
" Disable showing current function in airline
let g:airline#extensions#tagbar#enabled = 0
" Better showing of open buffers (open files), integrates with airline
" Plug 'bling/vim-bufferline'
" Plug 'alisnic/vim-bufferline'

" Version control notes in the line number bar
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" default updatetime 4000ms is not good for async update
set updatetime=100


" Git wrapper
Plug 'tpope/vim-fugitive'
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


" Nice colour scheme
Plug 'kristijanhusak/vim-hybrid-material'

" Quick file system tree, mapped to Ctrl+n for quick toggle
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', 'tags']
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


if has('patch-8.0-1364')
    " Easily change position of windows
    " Requires vim 8.0.1364 or neovim (exact version uncertain).
    "  <c-w>gh: soft move left
    "  <c-w>gj: soft move down
    "  <c-w>gk: soft move up
    "  <c-w>gl: soft move right
    Plug 'andymass/vim-tradewinds'
endif


" Full path fuzzy file, buffer, mru, tag, ... finder
" Quickly open files, fuzzy search on name
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'mileszs/ack.vim'
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
set rtp+=/data/data/com.termux/files/usr/bin/fzf
Plug 'junegunn/fzf.vim'

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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Search contents of files with ripgrep
" https://sidneyliebrand.io/blog/how-fzf-and-ripgrep-improved-my-workflow
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir FilesPreview
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping the above functions to more easily accessible hotkeys.
" Simply type ; to search through buffers, leader-o to search through file
" names, leader-O to search through file names, showing a preview window,
" \t for tags, \c for (Git) commits and \f to search through contents of files
nmap ; :Buffers<CR>
nmap <Leader>o :Files<CR>
nmap <Leader>O :FilesPreview<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>c :Commits<CR>
" nmap <Leader>f :Find<CR>
nmap <Leader>f :Rg<CR>
nmap <Leader>l :Lines<CR>
" nmap <Leader>g :Rg<CR>

nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>

" Web Development/Filetype icons
" Needs a font like found at
" https://github.com/ryanoasis/nerd-fonts
Plug 'ryanoasis/vim-devicons'
" Set guifont when using gvim:
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

"
" undotree.vim : Display your undo history in a graph.
Plug 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1 " if undotree is opened, it is likely one
                                    " wants to interact with it.


" == Content convenience =======================================================

" transparent editing of gpg encrypted files. The filename must have a .gpg,
" .pgp or .asc suffix.
Plug 'jamessan/vim-gnupg'

" Typescript syntax file and more
Plug 'leafgarland/typescript-vim'
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" handling column separated data (csv)
Plug 'chrisbra/csv.vim'
autocmd BufNewFile,BufRead *.csv setlocal filetype=csv

" .tmux.conf highlighting, help- and command integration
Plug 'tmux-plugins/vim-tmux'

" Automatically insert matching close bracket where it belongs
"Plug 'seletskiy/vim-autosurround'
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

" Correct previous spelling error with Ctrl+l. jumps to the previous
" spelling mistake [s, then picks the first suggestion 1z=, and then
" jumps back `]a. The <c-g>u in the middle make it possible to undo
" the spelling correction quickly.
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Word completion from dictionary (on ctrl+space)
set complete+=kspell

" Map <F9> to show the highlight group under the cursor (mainly for debugging)
map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Show indentation marks, enables conceallevel 2, so for example hides quotes
" in json files
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┊'
"let g:indentLine_setConceal = 0
let g:indentLine_conceallevel = 1

" Colour-match brackets
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" Do not use rainbow parentheses in these file types:
let g:rainbow_conf = {
\  'separately': {
\    'todo': 0
\  },
\}

" Python goodness
" Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}

" Python autocompletion
" On a machine with a Python3-only vim, use system packages like:
" python-jedi python3-jedi to keep jedi working for Python 2 and 3.
" Also, vim-nox-py2 might be needed
Plug 'davidhalter/jedi-vim'
"let g:jedi#force_py_version = 2

" Even though in termux, ycm now compiles, one might want to not load it there
" with ~/.dot_no_ycm
let skip_ycm=fnamemodify(expand("$MYVIMRC"), ":p:h") . "/.dot_no_ycm"
if !filereadable(skip_ycm)  " Only load YouCompleteMe if ~/.dot_no_ycm does not exist
    " code-completion engine
    " sudo apt-get install build-essential cmake
    " sudo apt-get install python-dev
    " cd ~/.vim/bundle/YouCompleteMe
    " ./install.py  # For C-style languages: ./install.py --clang-completer
    Plug 'ycm-core/YouCompleteMe'
    " YouCompleteMe interpreter version (should be the same as what YCM was
    " compiled with):
    if filereadable('/data/data/com.termux/files/usr/bin/python3')
        " Running in Termux
        let g:ycm_server_python_interpreter = '/data/data/com.termux/files/usr/bin/python3'
    else
        let g:ycm_server_python_interpreter = '/usr/bin/python3'
    endif
    " Debug stuff
    "let g:ycm_server_keep_logfiles = 1
    "let g:ycm_server_log_level = 'debug'
endif

if filereadable(skip_ycm)  " Only load if YouCompleteMe is not loaded
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    " deoplete language plugins
    " https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
    " python:
    Plug 'zchee/deoplete-jedi'
    " Many, based on syntax files
    Plug 'Shougo/neco-syntax'
    " Flow autocompletion for deoplete
    Plug 'wokalski/autocomplete-flow'

    " You will also need the following for function argument completion:
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'

    let g:deoplete#enable_at_startup = 1

    " Enable tab complete
    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ deoplete#manual_complete()
endif


" Improved Django handling
Plug 'tweekmonster/django-plus.vim'


" Code checker. For python, install flake8 or pylint, preferably in the
" virtualenv. For Django support, install pylint-django
Plug 'dense-analysis/ale'
nmap <leader>= <Plug>(ale_fix)
" Quickly open the loclist to see syntax errors
nmap <leader>; :lopen<CR>
let g:ale_maximum_file_size = 500000  " Don't lint large files (> 500KB), it can slow things down
let g:ale_fixers = {}
" Python specific settings
let g:ale_fixers.python = ['isort']
let g:ale_fixers.javascript = ['eslint', 'prettier']

" See VIMHOME/after/ftplugin/python.vim for some pylint configuration, also checking whether a
" project uses Django

" Show errors or warnings in the statusline
let g:airline#extensions#ale#enabled = 1
" UI
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '>'

let g:ale_linters = {
\   'javascript': ['eslint', 'flow', 'prettier'],
\}


" Handy Markdown stuff
" Do not fold markdown files by default
let g:vim_markdown_folding_disabled = 1
set nofoldenable
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_new_list_item_indent = 2
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Use filetype name as fenced code block languages for syntax highlighting
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'python=python']
" Preview markdown files with :PreviewMarkdown - needs mdr from
" https://github.com/MichaelMure/mdr
Plug 'skanehira/preview-markdown.vim'
let g:preview_markdown_vertical = 1

" Navigate through and from markdown files
"Plug 'chmp/mdnav'
Plug 'aquatix/mdnav', { 'branch': 'fixes' }
" Only open these local files in vim, use pyfile for all others:
let g:mdnav#Extensions = '.md, .MD, .markdown, .todo, .txt, .rst'


" vimwiki
Plug 'vimwiki/vimwiki'
let wiki_1 = {}
let wiki_1.path = '~/phren/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

" vimwiki-markdown
let wiki_1.template_path = '~/phren/templates/'
let wiki_1.template_default = 'default'
let wiki_1.path_html = '~/phren/site_html/'
let wiki_1.custom_wiki2html = 'vimwiki_markdown'
let wiki_1.template_ext = '.tpl'
let $VIMWIKI_MARKDOWN_EXTENSIONS = 'wikilinks'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" Do not use vimwiki magic on non-wiki (markdown) files
let g:vimwiki_global_ext = 0

" Quick way of opening a window with backlinks to the current document
nmap <leader>wb :VimwikiBacklinks <CR>


" The NERD Commenter: A plugin that allows for easy commenting of code for
" many filetypes.
Plug 'preservim/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Highlight colours in CSS (and html) files
Plug 'ap/vim-css-color'

" Highlight colours in fish shell files
Plug 'dag/vim-fish'

" Highlight colours in jade/pug templates
Plug 'digitaltoad/vim-pug'

" Highlight nginx
Plug 'chr4/nginx.vim'

" Highlight jinja templates (e.g., .j2 files) and do proper indenting
Plug 'Glench/Vim-Jinja2-Syntax'
au BufNewFile,BufRead *.j2,*.jinja2 set ft=jinja

" Automatic generation of tags file (ctags: Exhuberant Ctags)
Plug 'ludovicchabant/vim-gutentags'
" know when Gutentags is generating tags (prints 'TAGS' in status-line)
set statusline+=%{gutentags#statusline()}
let g:gutentags_ctags_exclude = ["*.min.*", "build", ".bundle", ".git", "log", "node_modules", "tmp", "vendor", "*.vim/bundle/*", "*.vim/plugged/*"]
"let g:gutentags_trace = 1


" == Writing prose =============================================================

" Distraction-free writing, start with <Leader>V (\V or ,V in this config)
Plug 'junegunn/goyo.vim'
let g:goyo_width = 120

" Help focus on text by dimming other parts a bit
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 'Grey69'
let g:limelight_conceal_ctermfg = 145
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = '#b0b0b0'

" Helps with writing prose (better line breaks, agnostic on soft line wraps vs
" hard line breaks etc)
Plug 'reedes/vim-pencil'
" Disable automatic formatting, as this automatically merges lines devided by
" 1 hard enter only, which can be annoying
let g:pencil#autoformat = 0
" Do not insert hard line breaks in the middle of a sentence
let g:pencil#wrapModeDefault = 'soft'  " default is 'hard'

" Toggle Gogo with Limelight and Pencil together with ,V
nmap <leader>V :Goyo <bar> :Limelight!! <bar> :TogglePencil <CR>


" All of the plugins must be added before the following line
call plug#end()
" == End of plugins ============================================================


" Enable line numbers, highlighting of current line by default; syntax
" highlighting is enabled by vim-plug
set number
set cursorline

if has('patch-7.4-338')
    " automatically indents wrapped lines up to the previous line. You can also
    " use the showbreak option to automatically indent the line even more
    set breakindent
endif

" Show tabs and trailspaces
set listchars=tab:▸\ ,trail:·
" Display whitespace
set list

" Trim trailing whitespace with :TrimWhitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

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

    set background=dark
    let g:enable_bold_font = 1
    let g:enable_italic_font = 1
    let g:hybrid_transparent_background = 1
    colorscheme hybrid_reverse

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
