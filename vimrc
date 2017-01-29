if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.leaders"))
  source ~/.vimrc.leaders
endif

runtime macros/matchit.vim
syntax enable
set background=dark
"set background=light
colorscheme solarized
set t_Co=256
set tabstop=2
set shiftwidth=2
set scrolloff=3
set backspace=2
set expandtab
set nocompatible
set number
set relativenumber
set encoding=utf-8
set splitbelow
set splitright
filetype plugin indent on

" Paste overriding selection
vnoremap p "_dP


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

" Powerline config
set laststatus=2

" Backup to ~/.tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Auto open nerdtree
map <C-d> :NERDTreeToggle<CR>
nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-E> :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Ctrlp.vim
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_open_new_file = 't'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|log$\|tmp$',
  \ }
"let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_show_hidden = 1


" Set spell checking for .markdown files
au BufRead,BufNewFile *.md set spell spelllang=en_gb
au BufRead,BufNewFile *.markdown set spell spelllang=en_gb
au BufRead,BufNewFile *.rabl setf ruby
au BufRead,BufNewFile *.xlsx.axlsx setf ruby

" go-vim
" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" React.js
let g:jsx_ext_required = 0

" Relative numbers
":au FocusLost * :set number
":au FocusGained * :set relativenumber
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber

" Ctags
map <Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git,pkg -languages=-javascript,sql<CR><CR>
set tags+=.git/tags

" Haml Lint
let g:syntastic_haml_checkers = ['haml_lint', 'haml']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
