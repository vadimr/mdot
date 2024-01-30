" __m4__

set nocompatible

scriptencoding utf-8
set encoding=utf-8

set hidden
set history=1000

set list listchars=tab:\ \ ,trail:·

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

set textwidth=80
set nowrap

set nohlsearch
set incsearch
set ignorecase
set smartcase

set complete=.,w,b

syntax on
set nonumber
set ls=2

set splitright
set splitbelow

set colorcolumn=81
hi ColorColumn ctermbg=8

" command! Txt set wrap linebreak | set columns=80
au BufRead,BufNewFile *.txt setlocal tw=80

hi Search cterm=NONE ctermbg=16
hi Visual ctermfg=black ctermbg=grey

set ruler

" let loaded_matchparen = 1
" hi MatchParen ctermfg=black
hi MatchParen ctermbg=darkgrey

set nofoldenable
set showcmd

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

set scrolloff=8

set path=$PWD

au BufRead,BufNewFile *.json,*.jsx set ft=javascript

cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

map <Leader>t :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
cmap w!! w !sudo tee > /dev/null %
map <C-f>f :vertical wincmd f<CR>

command RemoveTrailingSpaces %s/\s\+$//g

let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Copy to tmux
nmap yp :call system('tmux set-buffer "' . expand('%:p') . '"')<CR>
nmap y% :call system('tmux set-buffer "' . expand('%:p:h') . '"')<CR>

" Terminal
map <Leader>l :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd "$VIM_DIR" && clear<CR>
set shell=/bin/sh

" reload files modified externally
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

call plug#begin('~/.vim/plugged')

Plug 'REPDIR/vim/plugins/org'
Plug 'nelstrom/vim-visual-star-search'
Plug 'junegunn/fzf'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'tyru/open-browser.vim'
Plug 'powerman/vim-plugin-ruscmd'
Plug 'justinmk/vim-syntax-extra'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vadimr/bclose.vim'
Plug 'SirVer/ultisnips'
Plug 'jpalardy/vim-slime'
Plug 'jvirtanen/vim-hcl'

call plug#end()

map <silent> <Leader>z :Tabularize/\|<CR>

" fzf
nmap <c-p> :FZF<cr>
let g:fzf_layout = { 'down': '30%' }
" Hide status line
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" https://github.com/junegunn/fzf/wiki/Examples-(vim)

" FZF Old files
function! s:oldopen(lines)
  if len(a:lines) < 2 | return | endif
  let cmd = get({'ctrl-x': 'sp', 'ctrl-v': 'vs'}, a:lines[0], 'e')
  execute cmd . a:lines[1]
endfunction

command! FZFOld call fzf#run({
            \  'source': v:oldfiles,
            \  'sink*':  function('<sid>oldopen'),
            \  'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x',
            \  'down': '30%'
            \ })
nmap <Leader>o :FZFOld<CR>

" FZF Buffers
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(lines)
  if len(a:lines) < 2 | return | endif
  let cmd = get({'ctrl-x': 'sp', 'ctrl-v': 'vs'}, a:lines[0], 'e')
  let bufn = substitute(matchstr(a:lines[1], '^[ 0-9]*'), ' ', '', 'g')
  execute cmd . ' #' . bufn
endfunction

command! FZFBuf call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink*':   function('<sid>bufopen'),
\   'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x',
\   'down':    '30%'
\ })
nmap <Leader>b :FZFBuf<CR>

" if exists('$TMUX')
"     let g:fzf_layout = { 'tmux': '-p90%,60%' }
" else
"     let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" endif

" Quick run
nmap <Leader>r :QuickRun -mode n<CR>
vmap <Leader>r :QuickRun -mode v<CR>

" open-browser
nmap <Leader>s <Plug>(openbrowser-smart-search)
vmap <Leader>s <Plug>(openbrowser-smart-search)

" Bclose
map <silent> <Leader>w :Bclose<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories = ['REPDIR/vim/snippets/']

map <silent> <Leader>u :UltiSnipsEdit<CR>

" Slime
let g:slime_target = "tmux"
let g:slime_bracketed_paste = 1
