" File encoding to utf-8
set encoding=utf-8
set fileencodings=utf-8

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                            " than 50 lines of registers
set ruler		" show the cursor position all the time

" Rebind <Leader> key
let mapleader = ","

" Quicksave command
noremap <Leader>w :update<CR>
vnoremap <Leader>w :update<CR>

" Quick quit command
noremap <Leader>e :quit<CR> 	" Quit current window
noremap <Leader>E :qa!<CR> 	" Quit all windows

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-W>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <Leader>d <c-w>w

" Easier moving between tabs
map <S-h> <esc>:tabprevious<CR>
map <S-l> <esc>:tabnext<CR>

" Easier moving of code blocks
vnoremap < <gv	" better indentation
vnoremap > >gv	" better i

" Showing line numbers and length
set number	" show line numbers
set tw=79	" width of document (used by gd)
set nowrap	" don't automatically wrap on load
set fo-=t	" don't automatically wrap text when t

" Useful settings
set history=700
set undolevels=700

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Remap the space to / to search faster
map <Space> /

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Better navigating through omnicomplete option list using ctrl+j/k
set completeopt=longest,menuone,noinsert
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Set the copy to clipboard to 'y'
noremap y "*y

" Set the ESC key to fj
inoremap fj <Esc>

" To remap page up and down
noremap <S-j> <C-d>
noremap <S-k> <C-u>

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
Plug 'Lokaltog/vim-powerline'
Plug 'tomtom/tcomment_vim'
Plug 'tmhedberg/matchit'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'euclio/vim-markdown-composer'
Plug 'vim-airline/vim-airline'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'mhartington/deoplete-typescript'
Plug 'joshdick/onedark.vim'
Plug 'leafgarland/typescript-vim'
call plug#end()

" Typescript autocompletion
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 0
let g:auto_complete_start_length = 0
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_debug = 1
let g:deoplete#enable_profile = 1

autocmd VimEnter * NERDTree
map <Leader>t <plug>NERDTreeTabsToggle<CR>
autocmd VimEnter * wincmd p

" Set relative numbers
set relativenumber
set number

let g:deoplete#enable_at_startup = 1

syntax on
colorscheme onedark
