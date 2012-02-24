" Personal .vimrc file of tomskab
" Based on .vimrc file of Steve Francia:
" http://spf13.com/post/perfect-vimrc-vim-config-file

set nocompatible

" Chargement de pathogen
call pathogen#infect()

" General {
    if has('gui_running')
        set background=light
    else
        set background=dark
    endif

    if !has('win32') && !has('win64')
        set term=$TERM       " Make arrow and other keys work
    endif

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    set mouse=a                 " automatically enable mouse usage
    "set autochdir              " always switch to the current file directory.. Messes with some plugins, best left commented out
    " not every vim is compiled with this, use the following line instead
    " If you use command-t plugin, it conflicts with this, comment it out.
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    scriptencoding utf-8

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    "set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set spell                       " spell checking on
    
    " Setting up the directories {
        set backup                      " backups are nice ...
        " Moved to function at bottom of the file
        set backupdir=$HOME//.vim/.vimbackup//  " but not when they clog .
        set directory=$HOME/.vim/.vimswap//     " Same for swap files
        "set viewdir=$HOME/.vim/.vimviews//  " same for view files
        
        "" Creating directories if they don't exist
        silent execute '!mkdir -p $HOME/.vim/.vimbackup'
        silent execute '!mkdir -p $HOME/.vim/.vimswap'
        "silent execute '!mkdir -p $HOME/.vim/.vimviews'
        "au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
        "au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
    " }
" }

" Vim UI {
    "color solarized                 " load a colorscheme
    "let g:solarized_termcolors=256
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    "set cursorline                  " highlight current line
    "hi cursorline guibg=#333333     " highlight bg color of current line
    "hi CursorColumn guibg=#333333   " highlight cursor

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\   " Filename
        set statusline+=%w%h%m%r " Options
        "set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace for dummys
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high 
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set gdefault                    " the /g flag on :s substitutions by default
    set list
    set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with % 
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " On active le support pour twig
    au BufRead,BufNewFile *.twig set syntax=jinja
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" }


" Plugins {

    " PIV {
        "let g:DisableAutoPHPFolding = 0
        ""let cfu=phpcomplete#CompletePHP
    " }

    " Delimitmate {
        "au FileType * let b:delimitMate_autoclose = 1

        " If using html auto complete (complete closing tag)
        "au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
    " }
    
    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        "au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        "let g:snips_author = 'Thomas BIBARD <thomas.bibard@neblion.net>'
        " Shortcut for reloading snippets, useful when developing
        "nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
    " }

    " NerdTree {
        "nnoremap <silent> <F9> :NERDTree<CR>
        ""map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        ""map <leader>e :NERDTreeFind<CR>
        ""nmap <leader>nt :NERDTreeFind<CR>

        "let NERDTreeShowBookmarks=1
        "let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        "let NERDTreeChDirMode=0
        ""let NERDTreeQuitOnOpen=1
        "let NERDTreeShowHidden=1
        "let NERDTreeKeepTreeInNewTab=1
    " }

    " php-doc commands {
    "nmap <leader>pd :call PhpDocSingle()<CR>
    "vmap <leader>pd :call PhpDocRange()<CR>
    " }

" }



