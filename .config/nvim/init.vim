"                                 ___     
"        ___        ___          /__/\    
"       /__/\      /  /\        |  |::\   
"       \  \:\    /  /:/        |  |:|:\  
"        \  \:\  /__/::\      __|__|:|\:\ 
"    ___  \__\:\ \__\/\:\__  /__/::::| \:\
"   /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/
"   \  \:\|  |:|     \__\::/  \  \:\      
"    \  \:\__|:|     /__/:/    \  \:\     
"     \__\::::/      \__\/      \  \:\    
"         ~~~~                   \__\/    
"
"  NVIM Config
"  Callum Ward, 2019
"

" Set compatibility to Vim only.
set nocompatible

" Load plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'terryma/vim-smooth-scroll'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Vimjas/vim-python-pep8-indent'


" End plugins list
call plug#end()

" ============== Plugin Setup ===================
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

" Language servers
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['/usr/bin/pyls'],
    \ 'c': ['/usr/bin/ccls'],
    \ 'cpp': ['/usr/bin/ccls'],
    \ }

" Set colourscheme
colo dracula

"Always show current position
set ruler

" Turn on syntax highlighting.
syntax on

" Turn off modelines
set modelines=0

" Required for operations modifying multiple buffers like rename.
set hidden

" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
set textwidth=80
set cc=80

" C indentation
"   : - amount to indent 'case' labels relative to the corresponding 'switch'
"   t - function return type indentation
"   ( - after an unclosed '(', amount to indent following lines relative to the
"   character after the opening '('
"   w - if 1, '(0' aligns following lines with the first character after the
"   '(', rather than the first non-white character
"   W - after an unclosed '(' that's the last character on its line, amount to
"   indent the following lines
"
set cinoptions=:0t0(0w1Ws
" Fiddle with formatoptions to work nicely with comments
"   c - auto-wrap comments using textwidth
"   q - allow comment formatting with 'gq'
"   r - insert comment leader (e.g. ' *') after <Enter> in insert mode
"   o - insert comment leader after 'o' or 'O' in normal mode
"   n - indent numbered lists correctly
" NB: lots of people also have 't' enabled but I can't find what this does.
set formatoptions=tcqrn1

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
filetype indent plugin on

" Make header files show as "C" type by default
augroup filetypedetect
    au BufRead,BufNewFile *.h set filetype=c
augroup END

" Tweak filename tab completion, to:
"   - complete as much as possible (first tab)
"   - show a list of all matches (second tab)
"   - cycle through the options (more tabs)
set wildmode=longest,list,full

" Complete
"   - the longest common prefix;
"   - using a menu.
set completeopt=longest,menu
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Display options
set showmode
set showcmd
set cmdheight=1

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
"set list
"set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show relative line numbers, except when in insert mode or window
" is not focused (as absolute more useful)
set relativenumber
set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"
" Custom functions
"
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"############
"# Mappings #
"############

" Remap leader
let mapleader=" "
" Remap window prefix
nnoremap <Leader>w <C-w>
" Window commands
nnoremap <Leader>wd :q<CR>
" Search and replace
nnoremap <Space>rr :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
" Smooth scroll remaps
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 1, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 1, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 1, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 1, 4)<CR>
" Language client remaps
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" FZF map
nnoremap <Leader>ff :Files<CR>
" NerdTree
nnoremap <Leader>ft :NERDTreeToggle<CR>

" Setup easier buffer switching an context (Spacemacs mimic)
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" <Leader><Leader>: go to last used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>bb :ls<CR>
nnoremap <Leader><Leader> :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Set status line display
set laststatus=2
hi StatusLine ctermfg=NONE ctermbg=red cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=red cterm=NONE
hi User1 ctermfg=black ctermbg=magenta
hi User2 ctermfg=NONE ctermbg=NONE
hi User3 ctermfg=black ctermbg=blue
hi User4 ctermfg=black ctermbg=cyan
set statusline=\                    " Padding
set statusline+=%f                  " Path to the file
set statusline+=\ %1*\              " Padding & switch colour
set statusline+=%y                  " File type
set statusline+=\ %2*\              " Padding & switch colour
set statusline+=%=                  " Switch to right-side
set statusline+=\ %3*\              " Padding & switch colour
set statusline+=line                " of Text
set statusline+=\                   " Padding
set statusline+=%l                  " Current line
set statusline+=\ %4*\              " Padding & switch colour
set statusline+=of                  " of Text
set statusline+=\                   " Padding
set statusline+=%L                  " Total line
set statusline+=\                   " Padding

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch

" Enable incremental search
set incsearch

" Store info from no more than 100 files at a time, 9999 lines of text
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100
