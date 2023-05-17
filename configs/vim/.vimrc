set encoding=utf-8

set shell=/bin/bash

" Plug plugin manager
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" File navigation & search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'

" ------ Popup completion ------
Plug 'vim-denops/denops.vim'
" Plug 'vim-denops/denops-helloworld.vim'
Plug 'Shougo/ddc.vim'
" Sorters, matchers & converters
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-matcher_length'
Plug 'Shougo/ddc-sorter_rank'
Plug 'tani/ddc-fuzzy'
Plug 'matsui54/ddc-converter_truncate'
" Sources
Plug 'Shougo/ddc-around'
Plug 'LumaKernel/ddc-file'
Plug 'statiolake/ddc-ale'
Plug 'delphinus/ddc-ctags'
Plug 'matsui54/ddc-ultisnips'
Plug 'ippachi/ddc-yank'
" UIs
Plug 'Shougo/ddc-ui-native'

" ------ Linters & LSP ------
Plug 'dense-analysis/ale'
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install',
"   \ 'for': ['javascript', 'scss', 'jsx']
" \}

" ------ Common ------
Plug 'vim-scripts/vim-auto-save'
Plug 'tpope/vim-sensible'
Plug 'mbbill/undotree'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'

" ------ TreeView ------
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'

" ------ Syntax helpers ------
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'alvan/vim-closetag'

Plug 'vim-utils/vim-troll-stopper'

" ------ Snippets & completion ------
Plug 'ackyshake/VimCompletesMe'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" ------ Rails and rspec ------
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rails'
Plug 'alx741/spec.vim'
Plug 'dewyze/vim-ruby-block-helpers'

" ------ Test runner ------
Plug 'vim-test/vim-test'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-dispatch'

" ------ Git plugins ------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'idanarye/vim-merginal'
Plug 'samoshkin/vim-mergetool'
Plug 'APZelos/blamer.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Vim test
let test#strategy = {
  \ 'nearest': 'asyncrun_background_term',
  \ 'file':    'vimproc',
  \ 'suite':   'asyncrun_background_term',
\}
map <Leader>f  :TestFile<CR>
map <Leader>ss :TestNearest<CR>
map <Leader>s  :TestNearest -strategy=vimproc --no-color<CR>
map <Leader>a  :TestSuite<CR>
let test#ruby#rspec#options = {
  \ 'file':   '--no-color',
\}

" ALE init
let g:ale_completion_enabled = 1
let g:ale_linters = {
  \   'ruby': ['ruby', 'rubocop'],
  \   'javascript': ['eslint', 'prettier'],
  \   'javascriptreact': ['eslint', 'prettirer'],
\}

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
  \   '😞 %dW %dE',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

" Lightline - status bar
" https://github.com/itchyny/lightline.vim
set laststatus=2
set noshowmode

let g:lightline = {
  \   'active': {
  \     'left': [ [ 'mode', 'paste'  ],
  \               [ 'readonly', 'filename', 'modified' ],
  \               [ 'linterinfo' ]],
  \     'right': [ [ 'lineinfo'  ],
  \                [ 'percent'  ],
  \                [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \   },
  \   'component_function': {
  \     'linterinfo': 'LinterStatus',
  \   },
  \ }

" Disable lightline for NERDTree
" https://vi.stackexchange.com/questions/22398/disable-lightline-on-nerdtree
augroup filetype_nerdtree
  au!
  au FileType nerdtree call s:disable_lightline_on_nerdtree()
  au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
  let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
  call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

" Nerdtree
let NERDTreeMapOpenInTab='\r'
let NERDTreeShowHidden=1
" Let close window if only NERDTree left
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Mergetool
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" Auto save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0

" ddc auto complete
" call ddc#custom#patch_global('sources', ['around', 'yank', 'ale', 'ctags', 'file', 'ultisnips'])
call ddc#custom#patch_global('sources', ['around', 'ale', 'file', 'ultisnips'])
call ddc#custom#patch_global('sourceOptions', {
  \   '_': {
  \     'matchers': ['matcher_fuzzy', 'matcher_length'],
  \     'sorters': ['sorter_fuzzy'],
  \     'converters': ['converter_fuzzy', 'converter_truncate'],
  \   },
  \   'ale': {
  \     'mark': 'A',
  \     'matchers': ['matcher_head', 'matcher_length'],
  \     'sorters': ['sorter_rank'],
  \   },
  \   'ctags': {
  \     'mark': 'C',
  \     'matchers': ['matcher_head', 'matcher_length'],
  \     'sorters': ['sorter_rank'],
  \   },
  \   'yank': {
  \     'mark': 'Y',
  \   },
  \   'ultisnips': {
  \     'mark': 'US',
  \   },
  \   'file': {
  \     'mark': 'F',
  \     'isVolatile': v:true,
  \     'forceCompletionPattern': '\S/\S*',
  \   },
  \ })
call ddc#custom#patch_global('filterParams', {
  \   'converter_truncate': { 'maxAbbrWidth': 50, 'maxInfoWidth': 30 },
  \ })
call ddc#custom#patch_global('ui', 'native')

call ddc#enable()

" the_silver_searcher
let g:ackprg = "ag --nogroup --nocolor --column --ignore-case --ignore={'tmp*','.git*','node_modules'}"

" Far vim
set lazyredraw            " improve scrolling performance when navigating through large results
set ignorecase smartcase  " ignore case only when the pattern contains no capital letters"

" Ctrl+c copy
vnoremap <C-c> "*y"

" junegunn/fzf.vim
let g:fzf_buffers_jump = 1
let g:fzf_preview_window = 'right:40%'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline', '-i']}), <bang>0)
map <Leader>t :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
\}

nnoremap <C-g> :!lazygit<cr><cr>

" bkad/CamelCaseMotion
map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e

set listchars=eol:¬,tab:»»,trail:~,extends:>,precedes:<,space:·
set list

set timeoutlen=1000
set ttimeoutlen=0

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

set colorcolumn=100,120
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

" Change cursor shape for insert and replace mode for tmux in iTerm2.app
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Remove auto continuing comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Set YAML comment
autocmd BufNewFile,BufRead *.yaml,*.yml set filetype=yaml
autocmd FileType yaml setlocal commentstring=#\ %s

" Override syntax highlight
autocmd BufNewFile,BufRead *.inky set syntax=eruby
autocmd BufNewFile,BufRead *.arb,*.jb set syntax=ruby ft=ruby

set number relativenumber
set mouse=a

" Spell checking
autocmd FileType gitcommit,markdown,html,cucumber setlocal spell spelllang=en_us

" Onedark.vim
" https://github.com/joshdick/onedark.vim
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark
" colorscheme one
" set background=light
