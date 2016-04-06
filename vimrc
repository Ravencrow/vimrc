" File encoding to utf-8
set encoding=utf-8
set fileencodings=utf-8

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
                            " than 50 lines of registers
set ruler		" show the cursor position all the time

" Rebind <Leader> key
let mapleader = ","

filetype off
" Setting up Vundle - the vim plugin bundler
" Remember to use :BundleInstall! every now and then
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
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
Bundle 'tomtom/tcomment_vim'
Bundle 'tmhedberg/matchit'
Bundle 'Syntastic'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'altercation/vim-colors-solarized.git'
Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'vim-scripts/php.vim-html-enhanced'
Bundle 'kchmck/vim-coffee-script'
Bundle 'moll/vim-node'
Bundle 'Townk/vim-autoclose'
Bundle 'vim-scripts/closetag.vim'
Bundle 'ternjs/tern_for_vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'fatih/vim-go'

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
map <S-h> <esc>:tabprevious<CR>
map <S-l> <esc>:tabnext<CR>

" Easier moving of code blocks
vnoremap < <gv	" better indentation
vnoremap > >gv	" better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype on
filetype plugin on
filetype indent on
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

" Color scheme
syntax enable
" set t_Co=256
" color Solarized
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

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

" Set the ESC key to fj
inoremap fj <Esc>
" inoremap kj <Esc>
" inoremap jk <Esc>
" inoremap df <Esc>
" inoremap fd <Esc>

" Set Omnicompletion for different languages
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

let g:pymode_rope_lookup_project = 0
let g:SuperTabDefaultCompletionType = "context"
if has("gui_running")
    set background = "dark"
endif

autocmd BufNewFile,BufRead *.rb set filetype=ruby
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

" Set the keys to change from the action in the controller to the view in a
" rails project
noremap <Leader>r :R<CR>

" Omnicompletion shortcut
map! <C-Space> <C-X><C-O>

" " Snipmate shortcut
" :imap <Tab> <Plug>snipMateNextOrTrigger
" :smap <Tab> <Plug>snipMateNextOrTrigger
"
" CtrlP command
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Highlights ejs files
au BufNewFile,BufRead *.ejs set filetype=html

" Spacing for javascript and html = 2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal shiftwidth=4 tabstop=4
au BufRead,BufNewFile *.ts        setlocal filetype=typescript

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"
let g:UltiSnipsJumpBackwardTrigger="<c-s-space>"

" Relative number toggle
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" nnoremap <C-n> :call NumberToggle()<cr>
set relativenumber
set number
let g:typescript_indent_disable = 1

" Tern related
let g:tern_map_keys = 1
let g:tern_show_argument_hints = 'on_hold'
noremap <Leader>td :TernDoc<CR>
noremap <Leader>tt :TernType<CR>
noremap <Leader>td :TernDef<CR>
noremap <Leader>tR :TernRename<CR>
