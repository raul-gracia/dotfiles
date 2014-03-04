if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.leaders"))
  source ~/.vimrc.leaders
endif

syntax enable
set background=dark
colorscheme solarized
set shell=bash
:let $PATH=$PATH . ':' . $HOME . '/.rvm/bin'
set t_Co=256
set tabstop=2
set shiftwidth=2
set scrolloff=3
set textwidth=80
set expandtab
set nocompatible
filetype off
filetype plugin indent on

" Paste overriding selection
vnoremap p "_dP

nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-F> <C-h><C-h>:vertical resize 40<CR><C-l>

" Remove trailling space on save
autocmd BufWritePre * :%s/\s\+$//e

" EasyAlign remap
vnoremap <silent> <Enter> :EasyAlign<cr>

" Hightlihg the 79 column, as maximun line lenght
:highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
:set colorcolumn=80

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" Better window movement
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Powerline config
set laststatus=2
set rtp+=~/powerline/powerline/bindings/vim

" Backup to ~/.tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
