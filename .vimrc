set nocompatible " Use VIM settings rather than Vi settings; this *must* be first in .vimrc 

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"syntax high
"add no plugin folder

"set runtimepath^=~/.vim/bundle/no_plugins.vim

"________
"no plugins lecture

" BASIC SETUP:
"
" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

filetype plugin on      " load filetype-specific plugin files (for netrw,i think) maybe on no plugin folder

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu "visual autocomplete for command menu
set path+=**"look into subdirectories

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - ^ means control
" - Use ^] to jump to tag under cursor (control ])
" - Use g^] for ambiguous tags (g control ])
" - Use ^t to jump back up the tag stack(control t) - go back from the jump
"   tags
"________

"add acurding to https://dougblack.io/words/a-good-vimrc.html
"
colorscheme gruvbox         " awesome colorscheme"
set bg=dark 		    "turn the scheme to dark mode (bg means background)
syntax enable           " enable syntax processing
set tabstop=4       	" number of visual spaces per TAB
set softtabstop=4   	" number of spaces in tab when editing
"set expandtab       	" tabs are spaces
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
"set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches.the switch is on the next lines and can be operate via F12 key
"toggles the switch: if highlight is on, then pressing F12 turns it off. And vica versa. HTH.
map  <F12> :set hls!<CR>
imap <F12> <ESC>:set hls!<CR>a
vmap <F12> <ESC>:set hls!<CR>gv
"folding:
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" toggle between number and relativenumber
map  <F11> :set relativenumber!<CR>
imap <F11> <ESC>:set relativenumber!<CR>a
vmap <F11> <ESC>:set relativenumber!<CR>gv
nnoremap <F5> :UndotreeToggle<CR>

" toggle spell checking in order to spell fix hit z=<num> when on a mis-splled
" word on normal mode
set spell spelllang=en_us
set nospell
map  <F10> :set spell!<CR>
imap <F10> <ESC>:set nospell<CR>a
vmap <F10> <ESC>:set nospell<CR>gv

"plugins im using vim plug as my plugin manger
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" Plug 'tpope/vim-sensible'
Plug 'mbbill/undotree'
" Plug 'junegunn/seoul256.vim'
Plug 'preservim/nerdtree'
"Plug 'scrooloose/syntastic'
"for python development
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-surround'
Plug 'chrisbra/vim-commentary'
Plug 'tmhedberg/SimpylFold'
"Plug 'ctrlpvim/ctrlp.vim'


Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }
" List ends here. Plugins become visible to Vim after this call.
"
Plug 'lervag/vimtex'

Plug 'greyblake/vim-preview'
"for search within files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'
call plug#end()
"syntastic recomended setings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nerdTree
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif


" python
let python_highlight_all=1
syntax on

imap <f2> <c-o>:call ToggleHebrew()<cr>
map <f2> :call ToggleHebrew()<cr>

func! ToggleHebrew()
  if &rl
    set norl
    set keymap=
  else
    set rl
    set keymap=hebrew
  end
endfunc

"write this in the futhure
:map <C-j> ciw<C-r>0<ESC>
:map <C-k> ciW<C-r>0<ESC>

" for folding preview

"let g:SimpylFold_docstring_preview=1
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }
map  <C-x> :Ag<CR>
