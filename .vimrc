set nocompatible                      "enable vim features
filetype on                           "mac workaround, some strangeness happens otherwise
filetype off

"Vundle Plugin Manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'gmarik/ingretu'
colorscheme ingretu

"Use jk to exit insert mode.  Quick to type, and a NOP in normal mode.  Ignore
"accidental capitalization.
imap jk <esc>
imap Jk <esc>
imap JK <esc>

"===== General Setup =====
let mapleader = ";"
let g:mapleader = ";"
let maplocalleader = ","

set title                             "have vim set terminal title
set mouse=a                           "mouse use is occasionally convenient
set tabpagemax=100                     "open up to this many tabs when called with -p
set wildmode=list:longest             "enable shell-like tab completion in ex commands
set history=1000                      "history entries to remember (ex command, search, etc)
set timeoutlen=500                    "time in ms before partial commands time out
set showcmd                           "show partially input commands in lower right corner
set vb t_vb=                          "turn off beep
set ruler                             "show line/col in bottom row

"tabs
set expandtab                         "use all spaces instead of tabs
set tabstop=2                         "size of a tab
set softtabstop=2                     "size of a tab when editing
set shiftwidth=2                      "spaces to use for each autoindent
set smarttab                          "make spaces behave more like tabs

"searching
set hlsearch                          "highlight search terms
set ignorecase | set smartcase        "case insensitive iff no capitalization
set incsearch                         "search incrementally as you type
set gdefault                          "makes all-occurrences substitution the default
nnoremap <Leader>n :nohlsearch<CR>

"persistent undo
set undodir=~/.vim/undo
set undofile

"window splitting rules
set splitbelow                        "new windows created below the current one
set splitright                        "new windows created to the right of the current one

"slightly easier external copy/pasting
nnoremap <Leader>p "+p
vnoremap <Leader>y "+y

"easier mapping for last edited location
nmap <Leader>. `.

"toggle spell checking
nnoremap <Leader>s :set spell! \| set spell?<CR>

"Notes
"  some simple format, indent, and highlighting rules for note files
function NoteEdit()
  setlocal formatoptions=awtqnj1
  setlocal noexpandtab
  setlocal linebreak
  setlocal textwidth=80
  setlocal autoindent
  setlocal comments=fb:-,fb:*,fb:[\ ],fb:[x],fb:[-]
  syntax match incompleteItem "^\s*\[ \] \zs\(\( *[^ ]\)*\( \n\)\?\)\+"
  syntax match partialItem    "^\s*\[-\] \zs\(\( *[^ ]\)*\( \n\)\?\)\+"
  syntax match completeItem   "^\s*\[x\] \zs\(\( *[^ ]\)*\( \n\)\?\)\+"

  highlight incompleteItem ctermfg=202
  highlight partialItem    ctermfg=14
  highlight completeItem   ctermfg=68

  NeoCompleteLock
endfunction

au BufRead,BufNewFile *.note call NoteEdit()

"===== General Plugins =====
Bundle 'YankRing.vim'
"saves previous yanks and shares them between vim processes
"(after putting) <C-p>        replace put text with previous yank
"(after putting) <C-n>        replace put text with next yank
"yr                           show yank history
nnoremap <silent> yr :YRShow<CR>
"  make Y more like D or C
let g:yankring_n_keys = 'D x X'
nmap Y y$

Bundle 'EasyMotion'
"an alternative to motion repeats - a quick way to move around
"<Leader><Leader>(any motions command)      activate easymotion with that command

Bundle 'ZoomWin'
"temporarily fullscreen a split
"<C-w>o          toggle fullscreen

Bundle 'sudo.vim'
"use sudo for reading/writing files when opening a file prefixed with 'sudo:'

Bundle 'chrisbra/Recover.vim'
"give option to diff recovery files
":FinishRecovery       deletes swapfile and closes diff window

Bundle 'sjl/gundo.vim'
"visualize undo tree
":GundoToggle          display undo tree in split window

Bundle 'bling/vim-airline'
"nice statusline
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.whitespace = 'Ξ'

"==== GVim ====
set gfn=Inconsolata:h18

"===== General Programming =====
set showmatch                         "briefly shows matching brackets when closed
set matchtime=1                       "time for match to be shown in tenths of a second
set autowrite                         "write file before make
set formatoptions+=j                  "remove comment leader before joining lines
"  don't insert comment leader when making a new line with o
autocmd BufEnter * :set formatoptions-=o
"  format comment paragraphs
nnoremap <Leader>q gqip
vnoremap <Leader>q gq

"folding
set foldmethod=syntax
set foldnestmax=1                     "only ever have one level of folds
set foldlevelstart=1                  "start with everything visible

"diffs
"<Leader>d   diff all split windows
nmap <Leader>d :windo diffthis \| windo diffupdate<CR>

"===== Programming Plugins =====
Bundle 'tpope/vim-fugitive'
"git integration
":Gdiff     git diff the current file
":Gblame    git blame the current file
"a number of other commands along the same lines

Bundle 'tpope/vim-surround'
"deals with surroundings e.g. parens, quotes, brackets, etc
"ys(motion)(surrounding)         add (surrounding) around (motion)
"cs(surrounding)(surrounding)    change first (surrounding) to second (surrounding)
"ds(surrounding)                 delete innermost (surrounding)
"<Leader>(number)(surrounding)   add (surrounding) to (number) words
nmap <Leader>1 ys1w
nmap <Leader>2 ys2w
nmap <Leader>3 ys3w
nmap <Leader>4 ys4w

Bundle 'tpope/vim-abolish'
"allows conversion between camelCase and snake_case, etc
"crs       convert to snake_case
"crc       convert to camelCase
"cru       convert to COMMENT_CASE

Bundle 'tpope/vim-commentary'
"commenting/uncommenting
"<Leader><Space>    comment current line
"<Leader><Space>    comment selected lines
nmap <Leader><Space> gcc
vmap <Leader><Space> gc

Bundle 'tpope/vim-repeat'
"makes . work with more plugins

Bundle 'tpope/vim-dispatch'
"asynchronous dispatch/making

Bundle 'https://github.com/godlygeek/tabular'
"text alignment
"<Leader>=     align selected lines on the first =
vnoremap <Leader>= :Tabularize / = /l0<CR>

Bundle 'tommcdo/vim-exchange'
"easy text exchange operator
" cx{motion}      mark first text for exchange/perform exchange
" <Visual>X       mark first text for exchange/perform exchange

Bundle 'b4winckler/vim-angry'
"argument text objects

Bundle 'Shougo/vimproc.vim'
"asynchronous execution library needed by e.g. unite

Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neomru.vim'
"general purpose item listing/search plugin, primarily used for searching for files
"<Leader>f        recursively search for files in the current directory
"<Leader>F        search for recently used files
"<Leader>g        grep through files for word under cursor
"<Leader>G        grep through files
"(Unite)<C-c>     close unite window
"(Unite)q         go back once in unite window
"(Unite)<CR>      open
"(Unite)t         open in new tab
"(Unite)p         preview
"(Unite)<Tab>     perform alternate action
nnoremap <Leader>f :Unite -start-insert file_rec/async<CR>
nnoremap <Leader>F :Unite -start-insert file_mru<CR>
nnoremap <Leader>g :UniteWithCursorWord -start-insert grep:.<CR>
nnoremap <Leader>G :Unite -start-insert grep:.<CR>

"  don't quit unite on backspace
function s:unite_backspace()
  return col('.') <= (len(unite#get_current_unite().prompt)+1) ?  '' : "\<C-h>"
endfunction

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <buffer>                <C-w>     <Plug>(unite_delete_backward_path)

  nmap <buffer><expr>          t         unite#do_action("tabopen")
  nmap <buffer><expr>          <C-t>     unite#do_action("tabopen")
  imap <buffer><expr>          <C-t>     unite#do_action("tabopen")

  nmap <buffer>                <C-c>     <Plug>(unite_all_exit)
  imap <buffer>                <C-c>     <Esc><Plug>(unite_all_exit)
  imap <buffer>                <C-d>     <Esc><Plug>(unite_all_exit)

  imap <silent><buffer><expr>  <BS>      <SID>unite_backspace()
  imap <silent><buffer><expr>  <C-h>     <SID>unite_backspace()
endfunction

let g:unite_enable_start_insert = 1
let g:unite_split_rule = 'botright'
let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --hidden -g ""'
" don't limit the number of files to search through
let g:unite_source_rec_min_cache_files = 1000
let g:unite_source_file_rec_max_cache_files = 10000
let g:unite_source_rec_max_cache_files = 10000
call unite#custom#source('file_mru,file_rec,file_rec/async,grepocate',
        \ 'max_candidates', 10000)

if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  " Use ack in unite grep source.
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts =
        \ '--no-heading --no-color -a -H'
  let g:unite_source_grep_recursive_opt = ''
endif


Bundle 'https://github.com/Shougo/neocomplete'
"autocompletion plugin
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
"  only start completing if typing pauses
let g:neocomplete#enable_cursor_hold_i = 1
"  time in ms that typing has to pause before completion starts
let g:neocomplete#cursor_hold_i_time = 400

"  plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><C-e>     neocomplete#cancel_popup()

 " <CR>: close popup and save indent.
inoremap <expr><silent> <CR> <SID>my_cr_function()
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
endfunction

"  enable omni completion for languages neocomplete knows about
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags


Bundle 'https://github.com/rosenfeld/conque-term'
"turns a vim buffer into a terminal emulator
"ConqueTermSplit (command)    run (command) in a split window
"ConqueTermTab (command)      run (command) in a new tab
"<Leader>t                    send selected text to most recently created buffer
"<Leader>r                    open/reload current file in the appropriate interpreter
"<Leader>z                    open zsh in a tab
let g:ConqueTerm_StartMessages = 0
" let g:ConqueTerm_FastMode = 1
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_SendVisKey = "<Leader>t"
nmap <Leader>r :call <SID>reload_interpreter()<CR>
nmap <Leader>z :ConqueTermTab zsh<CR>

function s:reload_interpreter()
  let l:runprg = b:runprg
  write
  if exists("g:term")
    call g:term.focus()
    call g:term.close()
    quit
  endif
  let g:term=conque_term#open(l:runprg . ' '  . expand('%'), ['tabnew'], 0)
endfunction

autocmd FileType conque_term NeoCompleteLock


Bundle 'majutsushi/tagbar'
"compact function/variable list
"<Leader>'              open/close tagbar
nnoremap <silent> <Leader>' :TagbarToggle<CR>
"leave tags sorted by order of appearence in file
let g:tagbar_sort = 0


Bundle 'nathanaelkane/vim-indent-guides'
"more easily see indent levels
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_default_mapping = 0                 "don't add any mappings
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['unite', 'haskell', 'conque_term', 'help']
let g:indent_guides_auto_colors = 0                     "set colors manually
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235


Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
"Dash integration - fast function, etc lookup for mac
"<Leader>k            search for keyword under cursor in Dash
nmap <Leader>k <Plug>DashSearch

Bundle 'scrooloose/syntastic'
"realtime syntax checking
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_ignore_files=['.htm$']

"===== C =====
Bundle 'a.vim'
"quickly switch to and from header files
"<Leader>h            switch to/from header in current window
"<Leader>H            switch to/from header in new vertical split
nmap <Leader>h :A<CR>
nmap <Leader>H :AV<CR>

"===== Python =====
autocmd FileType python :let b:runprg='bpython -i'
Bundle 'klen/python-mode'
" comprehensive python mode

"===== Haskell =====
autocmd FileType haskell :let b:runprg='ghci'

let g:haskell_conceal=0

Bundle 'dag/vim2hs'
"indentation, better syntax highlighting, and more

Bundle 'ujihisa/neco-ghc'
"autocomplete

Bundle 'bitc/lushtags'
"tagbar support for haskell

autocmd FileType haskell :setlocal cole=0

command! -nargs=1 Hdoc !hoogle --info --color <f-args>
autocmd FileType haskell nmap <buffer> K :echo system("hoogle --info " . shellescape(expand("<cWORD>")))<CR>

"==== Golang ====
autocmd FileType go :let b:runprg='go run'

autocmd FileType go :call s:go_setup()

function s:go_setup()
  set noexpandtab
  nnoremap <Leader>= :Fmt<CR>
endfunction

Bundle 'jnwhiteh/vim-golang'
"syntax highlighting, indents, etc.  mirror of official repo

Bundle 'Blackrush/vim-gocode'
"autocompletion

"==== Java ====
autocmd FileType java :nmap <buffer> <Leader>k :JavaDocPreview<CR>
"eclim
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimJavaHierarchyDefaultAction = 'tabnew'
let g:EclimJavaCallHierarchyDefaultAction = 'tabnew'

autocmd FileType javadoc_preview :set linebreak

"==== Javascript ====
autocmd FileType javascript :call s:javascript_setup()

" Bundle "pangloss/vim-javascript"
"better syntax and indent for javascript

Bundle 'heavenshell/vim-jsdoc'
" JsDoc comment insertion
nmap <Leader>l :JsDoc<CR>
let g:jsdoc_allow_input_prompt = 0
let g:jsdoc_default_mapping = 0

function s:javascript_setup()
  set tabstop=4                         "size of a tab
  set softtabstop=4                     "size of a tab when editing
  set shiftwidth=4                      "spaces to use for each autoindent
  AddTabularPipeline! docblock /@.*{/
    \   tabular#TabularizeStrings(a:lines, '^[^{]*\zs{', 'l1c0l0')
    \ | tabular#TabularizeStrings(a:lines, '^[^@]*@\(return[^}]*}\|param[^}]*}\s*\h\w*\)\zs', 'l0l5l0')
endfunction

command FormatJSON %!python -m json.tool

"==== Less ====
Bundle 'groenewege/vim-less'
"highlighting, completion

"==== Markdown ====
Bundle 'tpope/vim-markdown'
Bundle 'suan/vim-instant-markdown'
"instant markdown updates
" :InstantMarkdownPreview
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0

"=== Experimental ===

"==== Final Commands ====
filetype plugin indent on             "enable filetype detection for indents and plugins
syntax enable                         "enable syntax highlighting

"==== Disabled Plugins ====
" Bundle 'airblade/vim-gitgutter'
" "show git changes in gutter
" -> Tried it, but didn't find it particularly useful

" Bundle 'terryma/vim-multiple-cursors'
" "multiple cursor support
" "<C-j>     create new cursor (or find next matching location and create cursor there)
" "<C-p>     remove last cursor and go to previous location
" "<C-x>     remove last cursor and continue to next location
" "<Esc>     exit multi-cursor mode
" let g:multi_cursor_use_default_mapping = 0
" let g:multi_cursor_next_key = '<C-j>'
" let g:multi_cursor_prev_key = '<C-p>'
" let g:multi_cursor_skip_key = '<C-x>'
" let g:multi_cursor_quit_key = '<Esc>'
" let g:multi_cursor_exit_from_insert_mode = 0
" -> Too buggy/annoying to use to be actually useful

" Bundle 'Raimondi/delimitMate'
" "automatically close pairs (e.g. parens)
" "(insert mode after opening a pair)<C-f>        jump to outside of pair
" imap <C-f> <Plug>delimitMateS-Tab
" let g:delimitMate_expand_cr=1
" let g:delimitMate_expand_space=1
" let g:delimitMate_balance_matchpairs=1
" autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
" -> delimitmate has problems with undo and '.', as do most (all?) other plugins of its type


"==== Plugins Under Consideration ====
" tpope/vim-unimpaired: pairs of handy bracket mappings
" vim-seek: (like f but for two characters): https://github.com/goldfeld/vim-seek
" Better whitespace (highlights trailing whitespace): https://github.com/ntpeters/vim-better-whitespace
