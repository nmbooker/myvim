" An example for a vimrc file.
"
" Maintainer:	Nick Booker <Bram@vim.org>
" Based on Bram Moolenar's example from 2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" See ~/.vim/autoload/pathogen.vim and http://www.vim.org/scripts/script.php?script_id=2332
call pathogen#infect()

set laststatus=2

let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic']

"let g:haskell_conceal_wide = 1
let g:haskell_conceal = 0

"let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("gui_running")
  " See http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
  set guioptions-=T
  set guioptions-=m

  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
  nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
  "nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

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

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

"set autoindent		" always set autoindenting on

endif " has("autocmd")

set wildmenu
set mouse=a

map <F10> <Esc>:setlocal spell spelllang=en_gb<CR>
map <F11> <Esc>:setlocal nospell<CR>

set fileencodings=utf-8,latin1
syntax on

set softtabstop=4 shiftwidth=4 tabstop=4 "textwidth=80

set autoindent incsearch wildmenu number smartindent linebreak expandtab
set smartcase showcmd
"set showbreak=>>
set showmatch
set listchars=tab:>-,trail:_ list
colorscheme desert
set background=light        " have to toggle this back and forth for some reason
set background=dark

"set gfn=DejaVu\ Sans\ Mono\ 10
set gfn=DejaVu\ Sans\ Mono\ 9
"set nohls

filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on

autocmd FileType ruby set sts=2 ts=2 sw=2 et ai


set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

" Python shortcuts
" Jump to next <++> placeholder, and optionally edit:
" DEPRECATED - Use Ctrl+J from imaps.vim instead.
"  Just jump to it
   autocmd filetype python map \X /<++>
"  Replace it
   autocmd filetype python map \C cf>
"  Jump to and replace <++> from command mode
   autocmd filetype python map <F4> \X\C
"  Jump to and replace <++> in insert mode
   autocmd filetype python map! <F4> \X\C

" \cs inserts a subclass definition (derived from another class)
autocmd filetype python map \cs oJclassx 
" \cc inserts a top-level class definition (derived from 'object')
autocmd filetype python map \cc oJclass 
" \mi inserts a method
autocmd filetype python map \mi oJdefi 
" \mI inserts an __init__ method
autocmd filetype python map \mI oJdefI 
" \fm inserts a function
autocmd filetype python map \fm oJdefm 

" These abbreviations are probably more natural than the commands above.
"  defm: Define a module-level function
"  defi: Define an instance method
"  defI: Define an __init__ instance method
"  class: Define a class derived from 'object'.
"  classx: Define a class extending another class other than 'object'.
autocmd filetype python abbrev Jdefm def<++>(<++>):"""<++>"""<++>?def^\X\C
autocmd FileType python abbrev Jdefi def<++>(self<++>):"""<++>"""<++>?def^\X\C
autocmd filetype python abbrev JdefI def __init__(self<++>):"""<++>"""<++>?def^\X\C
" autocmd filetype python abbrev class \cc
autocmd filetype python abbrev Jclass class<++>(object):"""<++>"""<++>?class\X\C
" autocmd filetype python abbrev classx \cs
autocmd filetype python abbrev Jclassx class<++>(<++>):"""<++>"""<++>?class\X\C


" Ruby shortcuts
" Jump to next <++> placeholder, and optionally edit:
" DEPRECATED: Use Ctrl+J from imaps.vim instead.
"  Just jump to it
   autocmd filetype ruby map \X /<++>
"  Replace it
   autocmd filetype ruby map \C cf>
""  Jump to and replace <++> from command mode
"   autocmd filetype ruby map <F4> \X\C
"  Jump to and replace <++> in insert mode
"   autocmd filetype ruby map! <F4> \X\C

autocmd FileType ruby map \cc oclass <++>end<<?class\X\C
autocmd FileType ruby abbrev Jclass classend<<?classA
autocmd FileType ruby abbrev Jdef defend?defA
autocmd FileType ruby map \fm odef <++>end<<?def\X\C

" Shell shortcuts
" Jump to next <++> placeholder, and optionally edit:
"  Just jump to it
   autocmd filetype sh map \X /<++>
"  Replace it
   autocmd filetype sh map \C cf>
"  Jump to and replace <++> from command mode
   autocmd filetype sh map <F4> \X\C
"  Jump to and replace <++> in insert mode
   autocmd filetype sh map! <F4> \X\C
autocmd FileType sh abbrev Jif if<++> ; then<++>fi<++><<?if\X\C

" Command line tools - The following need Conqueterm installed in your .vim
command Shell ConqueTermSplit bash
command Shellv ConqueTermVSplit bash
" It may seem odd not making this ruby-specific, but I don't want to have
" to load a Ruby source file specifically to be able to use this.
command RailsS ConqueTermSplit rails server
command RailsSV ConqueTermVSplit rails server
" Launch a git gui session in the current working directory.
command GitGui call system("git gui & disown")

" This launches NERDTree if vim is started without a file to open.
"autocmd vimenter * if !argc() | NERDTree | endif
"
autocmd filetype perl setlocal ts=4 sw=4 sts=4 et ai
autocmd filetype perl imap <M-,> => 
autocmd filetype perl imap <M-.> ->
autocmd filetype perl imap <M-!> #! /usr/bin/env perl

autocmd filetype yaml setlocal ts=2 sw=2 sts=2 et ai
autocmd filetype yaml setlocal cursorcolumn

autocmd FileType ruby abbrev <M-,> => 

inoremap <M-o> <C-x><C-o>

let g:pydiction_location = '$HOME/.vim/bundle/pydiction/complete-dict'

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"" http://vim.wikia.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier
vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap _[ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap _{ <Esc>`>a}<Esc>`<i{<Esc>

"" http://vim.wikia.com/wiki/Simple_placeholders
" Auto-close brackets on open
"inoremap ( ()<++><Esc>F)i
"inoremap [ []<++><Esc>F]i
"inoremap { {}<++><Esc>F}i
" C-j to jump to and replace next bit
"inoremap <c-j> <Esc>/<++><CR><Esc>cf>


" Config for Damian Conway's dragvisuals.vim ===============
vmap <expr> <LEFT>  DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN>  DVB_Drag('down')
vmap <expr> <UP>    DVB_Drag('up')
vmap <expr> D DVB_Duplicate()
" ==========================================================

" Swap : and ; from Damian Conway's Instantly Better Vim talk
nnoremap ; :
nnoremap : ;
" ==========================================================
