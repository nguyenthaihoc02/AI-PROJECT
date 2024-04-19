"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         > CONTACT INFORMATION <
" 
"        1. Name              : Nguyen Thai Hoc
"        2. Age               : 22
"        3. Anddress          : Bac Hai - Tien Hai - Thai Binh
"        4. Phone number      : 0834265442
"        5. Major             : Research Student / Junior Machine Learning
"        6. Email             : thaihocit02@gmail.com
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            # SETTING BASIC #
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number
set mouse=r
set clipboard=unnamedplus
set expandtab                
set tabstop=4                
set shiftwidth=4            
set listchars=tab:\¦\        
set list
set foldmethod=syntax         
set foldnestmax=1
set foldlevelstart=3          
set number                 
set ignorecase            

set nobackup
set nowritebackup
set nowb
set noswapfile

set synmaxcol=3000
set lazyredraw
au! BufNewFile,BufRead *.json set foldmethod=indent


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""# INSTALL PLUG #"""""""""""""""""""""""""""""
syntax on

call plug#begin("~/.config/nvim/plugged")

" 1. Themes 
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }

" 2. File manager
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'jcharum/vim-nerdtree-syntax-highlight',
    \ {'branch': 'escape-keys'}

" 3. Terminal
Plug 'voldikss/vim-floaterm'

" 4. Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 6. Support code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'liuchengxu/vista.vim'
                                                                     
" 7. Syntax hightling
Plug 'sheerun/vim-polyglot'


call plug#end()


colorscheme nightfly
let g:lightline = { 'colorscheme': 'nightfly' }
let g:nightflyCursorColor = v:true
let g:nightflyUnderlineMatchParen = v:true

nnoremap <C-f> :NERDTreeToggle<CR>
"let g:NERDTreeDirArrowExpandable = '?'
"let g:NERDTreeDirArrowCollapsible = '?'
let g:NERDTreeFileLines = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

hi FloatermNC guifg=gray
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_toggle = '<F8>'

function! AccentDemo()
  let keys = ['a','b','c','d','e','f','g','h']
  for k in keys
    call airline#parts#define_text(k, k)
  endfor
  call airline#parts#define_accent('a', 'red')
  call airline#parts#define_accent('b', 'green')
  call airline#parts#define_accent('c', 'blue')
  call airline#parts#define_accent('d', 'yellow')
  call airline#parts#define_accent('e', 'orange')
  call airline#parts#define_accent('f', 'purple')
  call airline#parts#define_accent('g', 'bold')
  call airline#parts#define_accent('h', 'italic')
  let g:airline_section_a = airline#section#create(keys)
endfunction
autocmd VimEnter * call AccentDemo()
let g:airline_theme='simple'


set nocompatible


set encoding=utf-8
set updatetime=300
set signcolumn=yes













