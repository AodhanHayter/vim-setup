execute pathogen#infect()
execute pathogen#helptags()

filetype on
filetype plugin on
syntax on
set term=xterm-256color
set encoding=utf-8
scriptencoding utf-8
set clipboard=unnamed
set colorcolumn=100
set number
set noshowmode
set nocompatible
set laststatus=2
let mapleader=" "
set backspace=indent,eol,start
map <leader>s :source ~/.vimrc<CR>

" use escape to remove highlight from search
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
nnoremap <esc>^[ <esc>^[

set updatetime=250
set hidden
set history=100

filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" remove whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" search highlight found words
set hlsearch

" show matching parens
set showmatch

" theme
colorscheme nova

" togglecursor setup
let g:togglecursor_insert = 'blinking_underline'

" delimitMate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1

" emmet settings
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" ale setup
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \}

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" nerd-tree setup
map <C-\> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

" nerd-commenter setup
let g:NERDSpaceDelims = 1

" command-t
let g:CommandTFileScanner = 'git'

" vim-wiki settings
let wiki = {}
let wiki.nested_syntaxes = {'javascript': 'js', 'python': 'python'}
let g:wiki_list = [wiki]

" lightline setup
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⭠ '.branch : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  let nr = bufnr('')
  return nr . ':' . ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
