" ================================================================================
" Plug
" ================================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'preservim/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
" Install fzf: brew install fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Set up language servers: CocInstall coc-sh coc-html coc-json coc-julia coc-pyright
Plug 'codota/tabnine-vim'
call plug#end()

" ================================================================================
" General setting
" ================================================================================
if empty(glob('~/.cache/vim'))
  silent !mkdir -p ~/.cache/vim
endif
set dir=~/.cache/vim
set backupdir=~/.cache/vim

set nobackup
set nowritebackup

set updatetime=200

set encoding=utf-8

set confirm
set hidden
set lazyredraw
set wildmenu

set title
colorscheme solarized
set background=dark
set guifont=Menlo-Regular:h16
set guicursor+=a:blinkon0
set belloff=all

set number
set signcolumn=number
set ruler
set laststatus=2
set cmdheight=1

syntax enable

set linebreak
set scrolloff=8
set sidescrolloff=8
set nofoldenable

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <leader> :nohlsearch<CR>
set showmatch

set mps+=<:>

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <Leader>r :Rg <C-R><C-W><CR>

" ================================================================================
" Plug setting
" ================================================================================
highlight SignColumn guibg=NONE guifg=NONE ctermbg=NONE ctermbg=NONE

let g:rainbow_active = 1

map <leader>t :NERDTreeToggle<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>prn :CocSearch <C-R>=expand("<cword>")<CR><CR>
