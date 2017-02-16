" File encoding to utf-8
set encoding=utf-8
set fileencodings=utf-8
set tabstop=2

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than 50 lines of registers
set ruler		" show the cursor position all the time
set guifont=Inconsolata_for_Powerline:h10
set guifont=Inconsolata\ for\ Powerline\ 10

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

" New tab
noremap <C-n> <C-t>

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

" Remap the space to / to search faster creating a bookomark to original
" location
map <Space> mm/

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

" Build Tsuquyomi Typescript plugin
function! BuildTsu(info)
				if a:info.status == 'installed' || a:info.force
								if has("mac")
												make -f make_mac.mak
								elseif has("linux")
												make
								endif
				endif
endfunction

call plug#begin('~/.config/nvim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'tmhedberg/matchit'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'euclio/vim-markdown-composer'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/deoplete.nvim'
Plug 'mhartington/deoplete-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'editorconfig/editorconfig-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'jason0x43/vim-js-indent'
Plug 'Shougo/vimproc.vim', { 'do': function('BuildTsu') }
Plug 'Quramy/tsuquyomi'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'Shougo/denite.nvim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'tpope/vim-fugitive'
call plug#end()

" Typescript autocompletion
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
				let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_debug = 1
let g:deoplete#enable_profile = 1
call deoplete#custom#set('buffer', 'min_pattern_length', 2)

" NerdTree config
map <Leader>t :NERDTreeTabsToggle<CR><Leader>d:NERDTreeTabsFind<CR>
map <Leader>f :NERDTreeTabsFind<CR>
let g:nerdtree_tabs_autofind = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_synchronize_view = 0
autocmd VimEnter * wincmd p

" Set relative numbers
set relativenumber
set number

" Color scheme
syntax on
set termguicolors
set background=dark
colorscheme solarized

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Cursor shape
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" omnifuncs
augroup omnifuncs
				autocmd!
				autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
				autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
				autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
				autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
				autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

				" tern
				if exists('g:plugs["tern_for_vim"]')
								let g:tern_show_argument_hints = 'on_hold'
								let g:tern_show_signature_in_pum = 1
								autocmd FileType javascript setlocal omnifunc=tern#Complete
								autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
				endif

				" deoplete tab-complete
				inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

				" Jump to a tag definition
				nnoremap gh <C-]>
				autocmd BufNewFile,BufRead *.js nnoremap gh :TernDef<CR>
				autocmd BufNewFile,BufRead *.ts nnoremap gh :TsuDefinition<CR>

				" QuickFix 'enter' open on new tab
				autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T

				" Autosave
				:au FocusLost * silent! wa


				" Ctags management
				let g:gutentags_exclude = ['dist', 'build']

				" Go to file extensions
				:set suffixesadd+=.js
				:set suffixesadd+=.ts

				" Allow jsx syntax in js files
				let g:jsx_ext_required = 0

				" Auto-indent
				noremap <C-i> migg=G'izz

				" Vim-airline
				let g:airline#extensions#tabline#enabled = 1
				let g:airline_powerline_fonts = 1

				" Delete trailing white spaces
				autocmd BufWritePre * %s/\s\+$//e

				" Disable linting on save for typescript
				let g:tsuquyomi_disable_quickfix = 1

				" Autoimport Typescript
				nmap <Leader>i :TsuImport<CR>

				" Denite config
				call denite#custom#var('grep', 'command', ['ag'])
				call denite#custom#var('grep', 'default_opts',
																\ ['-i', '--vimgrep'])
				call denite#custom#var('grep', 'recursive_opts', [])
				call denite#custom#var('grep', 'pattern_opt', [])
				call denite#custom#var('grep', 'separator', ['--'])
				call denite#custom#var('grep', 'final_opts', [])
				call denite#custom#var('file_rec', 'command',
																\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
				noremap <C-p> :Denite file_rec buffer colorscheme<CR>
				noremap <C-f> :Denite grep<CR>
				noremap <S-b> :DeniteCursorWord grep<CR>
				call denite#custom#map(
																\ 'insert',
																\ '<C-j>',
																\ '<denite:move_to_next_line>',
																\ 'noremap'
																\)
				call denite#custom#map(
																\ 'insert',
																\ '<C-k>',
																\ '<denite:move_to_previous_line>',
																\ 'noremap'
																\)
				call denite#custom#map(
																\ 'insert',
																\ '<CR>',
																\ '<denite:do_action:tabopen>:NERDTreeTabsFind<CR>',
																\ 'noremap'
																\)

				" Typescript parameters
				autocmd FileType typescript nmap <buffer> <C-u> :
																\ <C-u>echo tsuquyomi#hint()<CR>

				" Fugitive (Git plugin) config
				nmap <Leader>gd :Gdiff<CR>
				nmap <Leader>gb :Gblame<CR>
				nmap <Leader>gs :Gstatus<CR>
				nmap <Leader>gc :Gcommit<CR>
				nmap <Leader>gl :Glog<CR>

