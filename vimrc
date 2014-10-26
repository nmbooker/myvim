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
  "set guioptions-=m

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

autocmd filetype yaml setlocal ts=2 sw=2 sts=2 et ai
autocmd filetype yaml setlocal cursorcolumn

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

"" Swap : and ; from Damian Conway's Instantly Better Vim talk
"nnoremap ; :
"nnoremap : ;
"" ==========================================================

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)


" For latex-suite =====================================================
"
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
" =====================================================================


" For NERDTree ========================================================
map <C-n> :NERDTreeToggle<CR>
" =====================================================================

" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
tab sball
