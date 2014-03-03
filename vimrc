if filereadable(expand("~/.vimrc.bundles"))
	source ~/.vimrc.bundles
endif

syntax enable
set background=dark
colorscheme solarized
set shell=bash
:let $PATH=$PATH . ':' . $HOME . '/.rvm/bin'
set t_Co=256

map <leader>tt :call RunRspecLine(line('.'))<cr>
map <leader>TT :call RunRspec()<cr>

function! RunRspec()
	execute ":wa"
	exec ":!rspec % "
endfunction

function! RunRspecLine(args)
	execute ":wa"
	let cmd = ":!rspec %:" . a:args
	execute cmd
endfunction


"paste overriding selection
vnoremap p "_dP
nmap <leader>fef ggVG=<C-o><C-o>zz
set scrolloff=3

nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> <C-F> <C-h><C-h>:vertical resize 40<CR><C-l>
nmap <leader>cc :! cucumber %<CR>
nmap <leader>rd :redraw!<CR>
" Remove trailling space on save
autocmd BufWritePre * :%s/\s\+$//e

set nocompatible               " be iMproved
filetype off                   " required!

filetype plugin indent on     " required!

" EasyAlign remap
vnoremap <silent> <Enter> :EasyAlign<cr>

" Hightlihg the 79 column, as maximun line lenght
:highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
:set colorcolumn=80

" disable arrow keys
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

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>
