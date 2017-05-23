set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/bash
set t_Co=256
set term=screen-256color
set backspace=2



"---------------------------------------------------------
"			PLUGINS
"---------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim   " required
call vundle#begin()		    " required
Plugin 'VundleVim/Vundle.vim'	    " required
"--------------------------------------------------------
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'davidhalter/jedi-vim.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'

Plugin 'Valloric/YouCompleteMe'

"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"--------------------------------------------------------------





"--------------------------------------------------------------
"			SimplyFolded
"--------------------------------------------------------------
let g:SimpylFold_docstring_preview=1		" show docstrings for folded code

""""
" Airplane
""""
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
"let g:airline_powerline_fonts = 1


"""""""""""
" Key ReMapping
"""""""""""""
nnoremap <C-J> <C-W><C-J>		" ctrl+j move to the split below
nnoremap <C-K> <C-W><C-K>		" ctrl+k move to the split above
nnoremap <C-L> <C-W><C-L>		" ctrl+l move to the split to the right
nnoremap <C-H> <C-W><C-H>		" ctrl+h move to the split to the left
nnoremap <space> za			" spacebar folds methods/classes
map <C-n> :NERDTreeToggle<CR>		" open/close NERDTree

let NERDTreeIgnore = ['\.pyc$', '\~$', '\.swp$']	" ignore files in NERDTree

"-------------------------------------------------------
"			File Formatting
"-------------------------------------------------------
set nu				" show line numbers
set clipboard=unnamed		" use system clipboard
set encoding=utf-8		" set utf-8
set foldmethod=indent
set foldlevel=99
syntax on

" python highlighting
let python_highlight_all=1

au BufNewFile,BufRead *.py
    \ set tabstop=4      |
    \ set softtabstop=4  |
    \ set shiftwidth=4   |
    \ set textwidth=79   |
    \ set expandtab      |
    \ set autoindent     |
    \ set fileformat=unix 

au BufNewFile,BufRead *.js,*.json,*.html,*.css
    \ set tabstop=2      |
    \ set softtabstop=2  |
    \ set shiftwidth=2   

"--------------------------------------------------------
"			YouCompleteMe
"--------------------------------------------------------
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"-------------------------------------------------------
"			Python VirtualEnv
"-------------------------------------------------------
function LoadVirtualEnv(path)
	let activate_this = a:path . '/bin/activate_this.py'
	if getftype(a:path) == "dir" && filereadable(activate_this)
		python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
	endif
endfunction
let defaultvirtualenv = $HOME . "/.virtualenvs/stable"
if has("python")
	if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
		call LoadVirtualEnv(defaultvirtualenv)
	endif
endif


"----------------------------------------------------------
"			Color Scheme
"----------------------------------------------------------
set t_Co=256
set background=dark
colorscheme zenburn 
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE


"-----------------------------------------------------------
"			 Nerdtree
"----------------------------------------------------------
let NERDTreeShowHidden=1		" show hidden files
au vimenter * NERDTree			" show on start
au StdinReadPre * let s:std_in=1	

"au bufenter *									|	" close if only window open
"    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())	|
"    \ q										|
"    \ endif

au VimEnter *					|
    \ if argc() == 0 && !exists("s:std_in")	|
    \ NERDTree					|
    \ endif

au VimEnter *								|	"show when opening a directory
    \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")	|
    \ exe 'NERDTree' argv()[0]						|
    \ wincmd p								|
    \ ene								|
    \ endif
