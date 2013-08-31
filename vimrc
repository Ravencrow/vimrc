set pastetoggle=<F2>
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                            " than 50 lines of registers
set ruler		" show the cursor position all the time

" Rebind <Leader> key
let mapleader = ","

" Setting up Vundle - the vim plugin bundler
" Remember to use :BundleInstall! every now and then
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" Add your bundles here
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-surround'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'tomtom/tcomment_vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'vim-scripts/pythoncomplete'
Bundle 'jimf/javascriptcomplete'
Bundle 'mjbrownie/vim-htmldjango_omnicomplete'
Bundle 'Syntastic'
Bundle 'flazz/vim-colorschemes'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
"...All your other bundles...
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" Bind nohl
" Removes highlight of your last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

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
" Manage tabs
nnoremap <Leader>tn <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>tc :tabclose<CR>

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Easier moving of code blocks
vnoremap < <gv	" better indentation
vnoremap > >gv	" better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number	" show line numbers
set tw=79	" width of document (used by gd)
set nowrap	" don't automatically wrap on load
set fo-=t	" don't automatically wrap text when typing

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

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

filetype plugin on

" Color scheme
set t_Co=256
color wombat256mod

" Better navigating through omnicomplete option list using ctrl+j/k
set completeopt=longest,menuone
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

" Set the ESC key to vv
map! fj <Esc>l

" Set Omnicompletion for different languages
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" To remap omnicompletion
inoremap <Nul> <C-x><C-o>

" To remap page up and down
noremap <S-j> <C-d>
noremap <S-k> <C-u>

" Maximum number of characters per line with indicator
highlight ColorColumn ctermbg=0
if exists('+colorcolumn')
  set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
