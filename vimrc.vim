" Edsger Lin's vimrc
"
" Maintainer:   Edsger Lin <edsgerlinATgmailDOTcom>
" Last change:  2014-04-26
"
" To use it, copy it to
"   for Unix and OS/2:  ~/.vimrc
"   for Amiga:  s:.vimrc
"   for MS-DOS and Win32:  $VIM\_vimrc
"   for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" show English messages only
if has("unix")
    language C.UTF-8
elseif has("win32")
    language english
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"set backup             " keep a backup file
set nobackup            " do not keep a backup file, use versions instead
set history=300         " keep 300 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set showmode            " show current vim mode
set showfulltag         " get function usage help automatically
set incsearch           " do incremental searching
set showmatch           " show matching brackets
set ignorecase          " do case insensitive matching
set smartcase           " do smart case matching
set incsearch           " incremental search
set autoindent          " set autoindenting on
set smartindent         " automatically insert one extra level of indentation in
                        " some cases
set cindent             " smartindent for C & C++
set autowrite           " automatically save before commands like :next and make
set number              " show line numbers
set tabstop=4           " numbers of spaces of tab character
set shiftwidth=4        " numbers of spaces to (auto)indent
set shiftround          " (in|out)dent to nearest tabstops
set expandtab           " convert all tabs to spaces
set smarttab            " use spaces like a tab
set fileformat=unix     " use unix style end-of-line
" try following end-of-lines when reading a file
set fileformats=unix,dos,mac

if v:version >= 703     " if Vim 7.3 or later
    set colorcolumn=81  " set colored right-margin at column 81
endif

if has('multi_byte')
    " try following encodings when reading a file 
    set fileencodings=usc-bom,utf8,unicode,latin1,ansi,chinese,taiwan,japan,
                \korea

    " use UTF-8 as file encoding
    set fileencoding=utf8

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)' && v:version > 601
        set ambiwidth=double
    endif

    if has("win32")
        let &termencoding=&encoding
    endif
endif

if has("gui_running")   " start gvimrc
    
    " set font if has gui
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 10
    elseif has("gui_win32") || has("gui_mac")
        set guifont=Consolas:h11
    endif

    set lines=50                " height = 50 lines
    set columns=120             " width = 120 columns
    set selectmode=mouse,key,cmd
    set cursorline              " high light cursor line
    colorscheme evening

    if has("gui_win32")             " For Win32 GUI:
        " remove 't' flag from 'guioptions': no tearoff menu entries
        let &guioptions = substitute(&guioptions, "t", "", "g")        
    endif
endif                   " end gvimrc

" Don't use Ex mode, use Q for formatting
map Q gq

" Enable <Home> Key
map <Home> 1G
map! <Home> 1Gi

" Enable <End> Key
map <End> G
map! <End> Gi


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has("mouse")
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if has("syntax")
    syntax on
    set background=dark " using a dark background
endif

" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 80 characters.
    autocmd FileType text setlocal textwidth=80

    " When editing a file, always jump to the last known cursor position.
     " Don't do it when the position is invalid or when inside an event handler
     " (happens when dropping a file on gvim).
     " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    augroup END
    " Handle .md file correctly(Vim set filetype to Modula 2 by default).
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    " Enable javacomplete plugin
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

