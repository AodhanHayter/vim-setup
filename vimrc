execute pathogen#infect()
execute pathogen#helptags()

filetype on
filetype plugin on
syntax on
let python_highlight_all=1
set term=xterm-256color
set encoding=utf-8
scriptencoding utf-8
set clipboard=unnamed
set backupcopy=yes
set colorcolumn=100
set number
set relativenumber
set noshowmode
set nocompatible
set laststatus=2
set path+=**
set tags=tags;
set wildmenu
let mapleader=" "
set backspace=indent,eol,start

"leader maps
map <leader>s :source ~/.vimrc<CR>
map <leader>ff :NERDTreeFind<CR>
map <leader>co :set cursorcolumn! <bar> highlight CursorColumn guibg=yellow<CR>

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

" auto-tags
let g:autotagTagsFile='tags'

" delimitMate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1

" emmet settings
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" You complete me setup
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_semantic_triggers = {
  \ 'elm': ['.'],
  \}

" ale setup
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'elixir': ['credo'],
      \ 'python': ['flake8'],
      \ 'elm': ['elm-make']
      \}

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" nerd-tree setup
map <C-\> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp', '\.pyc', '__pycache__']

" nerd-commenter setup
let g:NERDSpaceDelims = 1

" command-t
let g:CommandTFileScanner = 'git'

" vim-wiki settings
let wiki = {}
let wiki.nested_syntaxes = {'javascript': 'js', 'python': 'python'}
let g:wiki_list = [wiki]

" dravisual settings
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
"Remove any introduced trailing whitespace after moving
let g:DVB_TrimWS = 1

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


"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" elm
let g:elm_format_autosave=1

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
