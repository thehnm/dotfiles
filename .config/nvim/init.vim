if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

set title
set titleold=st
set showmatch               " Show matching brackets.
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
"set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set splitright
set splitbelow
set noshowmode
set hidden
set nowrap
set linebreak
set fillchars=vert:│
set showcmd
set laststatus=0 " disable status bar
set conceallevel=2
set cursorline
set encoding=UTF-8

filetype off

" ----- Vundle ----------------------------------------------------------------"
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'ntpeters/vim-better-whitespace'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'neovimhaskell/haskell-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'kovetskiy/sxhkd-vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

let g:better_whitespace_enabled=1

autocmd BufWritePost * GitGutter

let g:vimtex_view_general_viewer = "zathura"
let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'nvim',
        \ 'background' : 1,
        \ 'build_dir' : 'build',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-pdf',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '-outdir=build',
        \   '-xelatex',
        \ ],
\}

map <F8> :BTags<CR>
map <C-a> :Rg<CR>
map <C-t> :Buffers<CR>
nnoremap <C-u> :GFiles?<CR>
nnoremap <C-f> :BLines<CR>

" Toggle highlight search
nnoremap <F3> : set hlsearch!<CR>

" Cycle through completions with TAB (and SHIFT-TAB cycles backwards)
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <C-W><C-S> :split<CR>
map <C-W><C-V> :vsplit<CR>

map <leader>, :bp<CR>
map <leader>. :bn<CR>

nnoremap <F9> : !texcount %:t<CR>

" Move around displayed lines
map j gj
map k gk

" Remap omnicomplete
inoremap <c-o> <c-x><c-o>

map <C-b> :NERDTreeToggle<CR>

" Allows auto-indenting depending on file type
filetype plugin indent on

" Disable vertical split border background
hi VertSplit cterm=None

" Disable banner when opening netrw
let g:netrw_banner = 0

set termguicolors
colorscheme nord

hi clear SignColumn

hi GitGutterAdd            guifg=#a3be8c
hi GitGutterChange         guifg=#ebcb8b
hi GitGutterDelete         guifg=#bf616a
hi GitGutterChangeDelete   guifg=#b48ead

let g:markdown_folding = 1
au FileType markdown setlocal foldlevel=1
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap <F5> :!make<CR>
