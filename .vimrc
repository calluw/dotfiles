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

 " Set compatibility to Vim only.
set nocompatible

" Import shared keybindings
" source ~/.vim/keybinds.vim

" Load plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sensible'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'terryma/vim-smooth-scroll'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'

" End plugins list
call plug#end()

" =========== Plugin Setup =========
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

" Set colourscheme
colo dracula

"Always show current position
set ruler

" Turn on syntax highlighting.
syntax on

" Column highlight
set cc=80

" Enable cscope
set cst
set nocsverb
if filereadable("cscope.out")
    cs add cscope.out
endif
set csverb

" C indentation
"   : - amount to indent 'case' labels relative to the corresponding 'switch'
"   t - function return type indentation
"   ( - after an unclosed '(', amount to indent following lines relative to the
"   character after the opening '('
"   w - if 1, '(0' aligns following lines with the first character after the
"   '(', rather than the first non-white character
"   W - after an unclosed '(' that's the last character on its line, amount to
"   indent the following lines
set cinoptions=:0t0(0w1Ws

" Fiddle with formatoptions to work nicely with comments
"   c - auto-wrap comments using textwidth
"   q - allow comment formatting with 'gq'
"   r - insert comment leader (e.g. ' *') after <Enter> in insert mode
"   o - insert comment leader after 'o' or 'O' in normal mode
"   n - indent numbered lists correctly
" NB: lots of people also have 't' enabled but I can't find what this does.
set formatoptions=cqron

" Tweak filename tab completion, to:
"   - complete as much as possible (first tab)
"   - show a list of all matches (second tab)
"   - cycle through the options (more tabs)
set wildmode=longest,list,full

" Complete
"   - the longest common prefix;
"   - using a menu.
set completeopt=longest,menu

" Turn off modelines
set modelines=0

" Smooth scroll remaps
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
filetype indent plugin on
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
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number
set relativenumber

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

" Include matching uppercase words with lowercase search term
set ignorecase

" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100
