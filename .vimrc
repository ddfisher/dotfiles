" David Fisher's vimrc
" currenty extremely disorganized due to rapid addition of many plugins
" will be cleaned up presently


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
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
colorscheme ingretu
" colorscheme Tomorrow-Night-Bright

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

set switchbuf=usetab,newtab
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

Bundle 'https://github.com/kien/rainbow_parentheses.vim.git'
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

Bundle 'Align'
" AlignMaps#Equals() changed slightly - now uses: AlignCtrl mWp1P1=l =
vmap ,a \t=

Bundle 'YankRing.vim'
nnoremap <silent> yr :YRShow<CR>

Bundle 'ZoomWin'
Bundle 'fugitive.vim'
Bundle 'EasyMotion'


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
Bundle 'https://github.com/tpope/vim-surround.git'
nmap ,2 ys2w
nmap ,3 ys3w
nmap ,4 ys4w

" extends CTRL-X/CTRL-A to work with dates and some other things (like ordinals!)
Bundle 'https://github.com/tpope/vim-speeddating.git'

" better search/replace (in certain cases), allows conversion between
" camelCase and snake_case
Bundle 'https://github.com/tpope/vim-abolish.git'

" simpler comment plugin
Bundle 'https://github.com/tpope/vim-commentary.git'
nmap <Leader><Space> \\\
vmap <Leader><Space> \\
autocmd FileType haskell :setlocal commentstring=--\ %s

" makes '.' work with more plugins
Bundle 'https://github.com/tpope/vim-repeat.git'

" don't continue the comment from the previous line on 'o'
autocmd BufEnter * :set formatoptions-=o

" automatic syntax checking
" Bundle 'https://github.com/scrooloose/syntastic'

" Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
" autocmd BufEnter *.tex :set cole=2
autocmd BufEnter *.tex :hi Conceal ctermbg=black
" set cocu=nc

Bundle 'actionscript.vim'
au BufNewFile,BufRead *.as  setf actionscript

" Bundle 'https://github.com/jpalardy/vim-slime.git'
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
" Bundle 'ctrlp.vim'
" let g:ctrlp_map = '<c-t>'

Bundle 'https://github.com/wincent/Command-T'
let g:CommandTMatchWindowReverse = 1
nmap <C-t> :CommandT<CR>

Bundle 'https://github.com/kchmck/vim-coffee-script'
au BufNewFile,BufRead *.coffee set filetype=coffee

autocmd BufEnter *.flex :setlocal filetype=lex

highlight Special ctermfg=45

" ========= test =======
" haskell
Bundle 'https://github.com/Shougo/vimproc'
Bundle 'https://github.com/eagletmt/ghcmod-vim'
nnoremap <silent> <Leader>g :GhcModCheck<CR>

" general completion
Bundle 'https://github.com/Shougo/neocomplcache'
Bundle 'https://github.com/ujihisa/neco-ghc'

autocmd BufEnter *.hs :NeoComplCacheEnable
" let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1

let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1

inoremap <expr><silent> <CR> <SID>my_cr_function()
function! s:my_cr_function()
  return pumvisible() ? neocomplcache#close_popup() . "\<CR>" : "\<CR>"
endfunction


" GHCi Interaction
Bundle 'https://github.com/vim-scripts/Superior-Haskell-Interaction-Mode-SHIM'
autocmd FileType haskell :nnoremap <buffer> <Leader>r :w<CR>:GhciFile<CR>
autocmd FileType haskell :vnoremap <buffer> <Leader>r :GhciRange<CR>

" Alignment
Bundle 'https://github.com/godlygeek/tabular'
" AddTabularPattern first_equals /^[^=]*\zs=
autocmd BufEnter *.hs :AddTabularPattern! equality / = /l0

" syntax checking
Bundle 'https://github.com/scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" type insertion, haddock lookup
Bundle 'https://github.com/ehamberg/haskellmode-vim.git'
let g:haddock_browser = "open"
let g:haddock_indexfiledir = "~/.vim/"
autocmd BufEnter *.hs :compiler ghc
let g:haddock_browser_callformat = "%s file://%s"

" vim2hs (BIG)
" Bundle 'https://github.com/dag/vim2hs'

" tags
Bundle 'https://github.com/majutsushi/tagbar'
Bundle 'https://github.com/bitc/lushtags'
let g:tagbar_compact = 1
nnoremap <silent> <Leader>' :TagbarToggle<CR>

" indent guides
Bundle 'https://github.com/nathanaelkane/vim-indent-guides'
" let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234

" using conceal for python
" cute, but probably not good
Bundle 'https://github.com/ehamberg/vim-cute-python'

Bundle 'sudo.vim'

" clojure
Bundle 'https://github.com/vim-scripts/VimClojure'

" rust
Bundle 'https://github.com/graydon/rust/tree/master/src/etc/vim'

" switch to and from header files
Bundle 'https://github.com/vim-scripts/a.vim'
nmap <Leader>h :A<CR>
nmap <Leader>H :AV<CR>

" experimental
Bundle 'https://github.com/goldfeld/vim-seek'
