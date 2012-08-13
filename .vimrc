" vundle
" run this for initial vundle setup:
" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible
filetype on "mac workaround
filetype off

" workaround needed on some systems:
" let $GIT_SSL_NO_VERIFY = 'true'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'https://github.com/gmarik/ingretu.git'
colorscheme ingretu

set rtp+=~/go/misc/vim
filetype plugin indent on

let mapleader = ";"
let g:mapleader = ";"

function TextEdit()
    setlocal formatoptions=1tcaw
    setlocal linebreak
    setlocal wrap
    setlocal nolist
    setlocal noexpandtab
    " nnoremap ^ g^
    " nnoremap $ g$
    " nnoremap j gj
    " nnoremap k gk
    " vnoremap j gj
    " vnoremap k gk
    set textwidth=98
endfunction

set mouse=a

command! -nargs=1 Silent
            \ | execute ':silent '.<q-args>
             \ | execute ':redraw!'

set switchbuf=usetab
command! -nargs=* -complete=shellcmd R execute "silent bo" bufnr("<Output>",1)."sb"
      \ | resize 10 
      \ | setlocal buftype=nofile bufhidden=hide noswapfile
      \ | execute "normal gg\"_dG"
      \ | execute 'r !<args>'
      \ | wincmd p
      \ | echo "<args>"

" if has('autocmd')
"     au BufRead,BufNewFile *.txt call TextEdit()
"     au BufRead,BufNewFile *.markdown call TextEdit()
"     au BufRead,BufNewFile *.tex call TextEdit()
" endif

syntax enable
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autowrite
imap jk <esc>
set title
set tabpagemax=100

set hlsearch
set incsearch
nnoremap / /\v
vnoremap / /\v
nnoremap <Leader>n :nohlsearch<CR>
set gdefault

nnoremap <Leader>q gqip

autocmd QuickFixCmdPost * :cw

"--- experimental ---
"general
set history=256  " Number of things to remember in history.
set timeoutlen=500
set showcmd

" show tab-completion menu, but make left and right arrow keys always move the
" cursor
set wildmenu
set wildmode=list:longest
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

"persistent undo
set undodir=~/.vim/undo
set undofile

"searching
set smartcase
set incsearch
 "tabs
set smarttab "delete at the beginning of the line deletes shiftwidth spaces
"C stuff
set showmatch "briefly shows matching parens, etc when closed
set matchtime=1
set foldmethod=syntax
set foldnestmax=1 "don't fold more than one level
set foldlevelstart=1
"split rules
set splitbelow
set splitright

set vb t_vb=  "turn off beep
set ruler "show line/col in bottom row

"Split line(opposite to S-J joining line) 
" nnoremap <silent> <C-J> gEa<CR><ESC>ew

Bundle "https://github.com/kien/rainbow_parentheses.vim.git"
let g:rbpt_colorpairs = [
    \ ['green',       'green'],
    \ ['magenta',     'magenta'],
    \ ['blue',        'blue'],
    \ ['red',         'red'],
    \ ['gray',        'gray'],
    \ ['brown',       'brown'],
    \ ['green',       'green'],
    \ ['magenta',     'magenta'],
    \ ['blue',        'blue'],
    \ ['red',         'red'],
    \ ['gray',        'gray'],
    \ ['brown',       'brown'],
    \ ['green',       'green'],
    \ ['magenta',     'magenta'],
    \ ['blue',        'blue'],
    \ ['red',         'red'],
    \ ]

nnoremap <Leader>p :RainbowParenthesesToggleAll<CR>

"Compiling
nnoremap ,m :make<CR>
nnoremap ,c :cw<CR>
nnoremap ,n :cn<CR>
nnoremap ,p :cp<CR>
nnoremap ,v "+p
vnoremap ,y "+y
nnoremap ,s :set spell! \| set spell?<CR>
nnoremap ,l :set number! \| set number?<CR>
nnoremap ,g :silent execute '!grep -r --color=always <cword> . \| less -R' \| redraw!<CR>
nnoremap ,r :if &autowrite \| silent w \| endif \| execute "R" b:runprg <CR>

Bundle "Align"
" AlignMaps#Equals() changed slightly - now uses: AlignCtrl mWp1P1=l =
vmap ,a \t=

Bundle "YankRing.vim"
nnoremap <silent> yr :YRShow<CR>

Bundle "ZoomWin"
Bundle "fugitive.vim"
Bundle "EasyMotion"


" very experimental
" Don't always show the statusline
set laststatus=1

" Format the statusline
set statusline=%<%f%h%m%r%h%w\ \|\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=%{HasPaste()}\ %l:%c/%L\ \ %P

function! HasPaste()
    if &paste
        return 'PASTE ON'
    else
        return ''
    endif
endfunction

" better surrounding with e.g. parens
Bundle "https://github.com/tpope/vim-surround.git"
nmap ,2 ys2w
nmap ,3 ys3w
nmap ,4 ys4w

" extends CTRL-X/CTRL-A to work with dates and some other things (like ordinals!)
Bundle "https://github.com/tpope/vim-speeddating.git"

" better search/replace (in certain cases), allows conversion between
" camelCase and snake_case
Bundle "https://github.com/tpope/vim-abolish.git"

" simpler comment plugin
Bundle "https://github.com/tpope/vim-commentary.git"
nmap <Leader><Space> \\\
vmap <Leader><Space> \\

" makes '.' work with more plugins
Bundle "https://github.com/tpope/vim-repeat.git"

" don't continue the comment from the previous line on 'o'
autocmd BufEnter * :set formatoptions-=o

" automatic syntax checking
" Bundle "https://github.com/scrooloose/syntastic"

" Bundle "LaTeX-Suite-aka-Vim-LaTeX"
autocmd BufEnter *.tex :set cole=2
autocmd BufEnter *.tex :hi Conceal ctermbg=black
set cocu=nc

Bundle "actionscript.vim"
au BufNewFile,BufRead *.as  setf actionscript

" Bundle "https://github.com/jpalardy/vim-slime.git"
let g:slime_target = "tmux"

" Google Go
autocmd BufEnter *.go :set makeprg=go\ $*\ %
autocmd BufEnter *.go :nnoremap ,m :Silent make build<CR>
" autocmd BufEnter *.go :nnoremap ,r :R ./#:r<CR>
autocmd BufEnter *.go :let b:runprg='./#:r'
autocmd BufEnter *.go :setlocal errorformat=%f:%l:\ %m

autocmd BufEnter *.rb :let b:runprg='ruby #'


" This is the shit
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$\|\.hg$\|\.svn$',
"   \ }
" Bundle "ctrlp.vim"
" let g:ctrlp_map = '<c-t>'

Bundle "https://github.com/wincent/Command-T"
let g:CommandTMatchWindowReverse = 1
nmap <C-t> :CommandT<CR>

Bundle "https://github.com/kchmck/vim-coffee-script"
au BufNewFile,BufRead *.coffee set filetype=coffee

autocmd BufEnter *.flex :setlocal filetype=lex

highlight Special ctermfg=45

" ========= test =======
" haskell
Bundle "https://github.com/Shougo/vimproc"
Bundle "https://github.com/eagletmt/ghcmod-vim"

" general completion
Bundle "https://github.com/Shougo/neocomplcache"
Bundle "https://github.com/ujihisa/neco-ghc"

" Haskell
" Bundle "https://github.com/ehamberg/haskellmode-vim.git"
" let g:haddock_browser = "open"
" let g:haddock_browser_callformat = "%s %s"

" function! EnableHlint()
"     if exists("hlint")
"       finish
"     endif
"     let current_compiler = "hlint"

"     let s:cpo_save = &cpo
"     set cpo-=C

"     setlocal errorformat=%f:%l:%c:\ %t%*[a-zA-Z]:\ %m
"     setlocal makeprg=hlint\ %

"     " ensure shellpipe is set to default (might be changed by 
"     " compiler/ghc.vim)
"     setlocal shellpipe=>

"     let &cpo = s:cpo_save
"     unlet s:cpo_save
" endfunction
" autocmd BufEnter *.hs :call EnableHlint()
" autocmd Bufenter *.hs compiler ghc


" Bundle "hlint"

" function! SetToCabalBuild()
"   if glob("*.cabal") != ''
"     set makeprg=cabal\ build
"   endif
" endfunction
" autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

" using conceal for python
" cute, but probably not good
Bundle "https://github.com/ehamberg/vim-cute-python"
