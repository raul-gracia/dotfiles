if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.leaders"))
  source ~/.vimrc.leaders
endif

syntax enable
"set background=light
set background=light
colorscheme solarized
set tabstop=2
set shiftwidth=2
set scrolloff=3
set backspace=2
set expandtab
set number
set relativenumber
set encoding=utf-8
set splitbelow
set splitright
set regexpengine=1
" highlight cursor position
set cursorline
set clipboard=unnamedplus
set ff=unix

filetype plugin indent on

" Paste overriding selection
xnoremap p "_dP

autocmd BufRead,BufNewFile,BufWritePre * :set ff=unix
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
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>i

" Backup to ~/.tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Set spell checking for .markdown files
au BufRead,BufNewFile *.md set spell spelllang=en_gb
au BufRead,BufNewFile *.markdown set spell spelllang=en_gb
au BufRead,BufNewFile *.rabl setf ruby
au BufRead,BufNewFile *.xlsx.axlsx setf ruby
autocmd FileType qf setlocal wrap linebreak
au BufRead,BufNewFile set ff=unix

" Relative numbers
:au FocusLost * :set number
:au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

" Don't automatically continue comments after newline
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
