set nocompatible

scriptencoding utf-8
set encoding=utf-8

set hidden
set history=1000

set list listchars=tab:\ \ ,trail:·

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

set textwidth=80

set nowrap

set nohlsearch
set incsearch
set ignorecase
set smartcase

set complete=.,w,b,u,t

syntax on
set nonumber
set ls=2

set splitright
set splitbelow

set colorcolumn=81
hi ColorColumn ctermbg=8

hi Search cterm=NONE ctermbg=16
hi Visual ctermfg=black ctermbg=grey

set ruler

let loaded_matchparen = 1

set nofoldenable

if has("persistent_undo")
  silent !mkdir ~/.vim/tmp/undo > /dev/null 2>&1
  set undodir=~/.vim/tmp/undo
  set undofile
endif

set shellcmdflag=-ic

set nobackup
set noswapfile
set nowb

set wildmenu
set wildmode=longest,list

set scrolloff=10

set path=$PWD

au BufRead,BufNewFile *.h,*.c,*.cu set filetype=cpp
au BufRead,BufNewFile Vagrantfile set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.go set filetype=go

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

map <Leader>t :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
cmap w!! w !sudo tee > /dev/null %
map <C-f>f :vertical wincmd f<CR>

map <Leader>v '[V']

command RemoveTrailingSpaces %s/\s\+$//g

call plug#begin('~/.vim/plugged')

Plug 'nelstrom/vim-visual-star-search'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'powerman/vim-plugin-ruscmd'
Plug 'justinmk/vim-syntax-extra'
Plug 'vadimr/bclose.vim'

call plug#end()

" ctrlp

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v\/(\.git|build|target|tmp|vendor|public\/assets|public\/uploads|node_modules)$',
\ 'file': '\v\.(o|so|fig|fst|mout)$',
\ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 'EVH'
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '2vjr'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_bufpath_mod = ':.:h'
let g:ctrlp_bufname_mod = ':t'

nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>m :CtrlPMRU<CR>
nmap <Leader>c :CtrlPChange<CR>
nmap <Leader>a :CtrlPChangeAll<CR>
nmap <Leader>% :CtrlP %%<CR>

" ctrlp tjump
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>

" Quick run
nmap <Leader>r :QuickRun -mode n<CR>
vmap <Leader>r :QuickRun -mode v<CR>

" Bclose
map <silent> <Leader>w :Bclose<CR>
