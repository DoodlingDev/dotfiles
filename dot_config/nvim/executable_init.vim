" core settings {{{
let g:mapleader=','         " map leader to comma
set shell=$SHELL            " set shell to system $SHELL
set encoding=utf-8          " set vim representing chars as utf-8 internally
set fileencoding=utf-8      " set encoding for files to utf-8
set noswapfile              " don't use vim's swap file feature
set scrolloff=10            " set cursor vertical offset from screen edge
set ruler                   " show cursor position in file in lower rt.
set showcmd                 " show partial cmd info on last line of screen

" coc nvim related config settings
set hidden                  " hide buffer when navigating away
set nobackup                " some language servers have issues w/ backup files
set nowritebackup           " ^^^
set cmdheight=2             " give coc more height for displaying messages
set updatetime=300          " longer updatetime leads to noticeable delays
set shortmess+=c            " don't pass messages to |ins-completion-menu|
set signcolumn=yes          " always show the signcolumn, otherwise text will
                            " shift each time diagnostics appear/resolve
			    "
set conceallevel=2
set backspace=2             " *
set history=200             " *
set autoread                " *
set autowrite               " *
set incsearch               " *
set foldlevelstart=25       " *
set foldmethod=manual       " *
set nohlsearch              " *
set lazyredraw              " Don't redraw during macros
set nojoinspaces            " Use one space, not two, after punctuation.
set tabstop=2               " tab = 2spaces
set smarttab                " soft tabs
set shiftwidth=2            " Number of spaces to use in autoindenting
set shiftround              " *
set expandtab               " *
set wrap                    " set linebreak
set linebreak               " Only break line at non-word character
set nolist                  " Only linebreak when I press enter
set formatoptions-=tc       " *
set textwidth=0             " *
set numberwidth=5           " *
set number                  " *
set splitbelow              " *
set splitright              " *
set diffopt+=vertical       " *
set laststatus=2            " *
set undofile                " *
set undodir=$HOME/.vim/undo " *
set undolevels=1000         " *
set undoreload=10000        " *
set mouse=a                 " *
set ignorecase              " *
set smartcase               " *
set previewheight=8         " Completion preview height
set clipboard=unnamed       " *
set colorcolumn=80          " show 80 column by changing bg color
set termguicolors           " enable 24-bit colors in the TUI
set foldmethod=syntax
" " }}}

" Plugins {{{
let g:plugin_dir = '~/.config/nvim/plugged'      " plugin control with Vim Plug
call plug#begin('~/.config/nvim/plugged')        " Begin Vim Plug

Plug 'drewtempelmeyer/palenight.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                                              "
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'                        " auto completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP & completion

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'benizi/vim-automkdir'                      " automatically make dirs
Plug 'jiangmiao/auto-pairs'                      " auto-pairs
Plug 'ervandew/supertab'                         " better <tab>
Plug 'tpope/vim-commentary'                      " easy commenting
Plug 'tpope/vim-surround'                        " add surround to text objects
Plug 'tpope/vim-fugitive'                        " vim-master's git
Plug 'christoomey/vim-conflicted'                " git conflict resolution
Plug 'alvan/vim-closetag'                        " close xml tags
Plug 'easymotion/vim-easymotion'                 " easy motions
Plug 'tpope/vim-endwise', { 'for': 'ruby' }      " add closings for ruby syntax
Plug 'junegunn/fzf.vim'                          " FZF pluign for vim
Plug 'junegunn/fzf',                             " FZF commands
      \ { 'dir': '~/.fzf',                       "   -
         \ 'do': './install --all' }             "   -
Plug 'vim-scripts/DrawIt'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'yaml', 'html'] }

Plug 'DoodlingDev/notational-fzf-vim'
let g:notes_directory = '/Users/aji/.wiki'
let g:nv_search_paths = [g:notes_directory]
let g:nv_create_note_key = 'ctrl-e'

Plug 'doodlingdev/vim-markdown',
      \ { 'for':
        \ ['markdown'] }                         " markdown support
let g:vim_markdown_new_list_item_indent = 2
Plug 'godlygeek/tabular'                         " align text, dep of vim-markdown

" Plug 'pangloss/vim-javascript'
"Plug 'yuezk/vim-js'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'MaxMEllon/vim-jsx-pretty'
"Plug 'jparise/vim-graphql'
"Plug 'challenger-deep-theme/vim'

Plug 'akiyosi/gonvim-fuzzy'
Plug 'folke/which-key.nvim'
Plug 'monsonjeremy/onedark.nvim'

call plug#end()                                  " }}}

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  require'lspconfig'.tsserver.setup{}

  require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
      path = true;
      buffer = true;
      calc = true;
      nvim_lsp = true;
      nvim_lua = true;
      vsnip = true;
      ultisnips = true;
    };
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = { "c", "rust" },  -- list of language that will be disabled
    },
  }
EOF

" Global variables {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:closetag_filenames = '*.html,*.js,*.xml'
" }}}

command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \'ag '.shellescape(<q-args>).'.', 0,
      \ fzf#vim#with_preview(), <bang>0
      \)

" auto commands {{{
autocmd BufWritePre * :%s/\s\+$//e               " remove trailing whitespace

autocmd BufWritePre *.{jsx,es6,js,tsx} :Prettier
autocmd BufWritePost *.{jsx,es6,js,tsx} :e %
autocmd BufRead,BufNewFile *.vim set foldmethod=marker " viml folding

" commented out because team isn't using prettier-ruby
" TODO: Figure out rubocop autoformat in vim
" autocmd FileType ruby let b:prettier_ft_default_args = { 'parser': 'ruby' }

filetype on                                      " filetypes {{{
" filetype plugin on
augroup vimrcEx
  autocmd!
  filetype plugin indent on
  autocmd BufRead,BufNewFile *.{txt,md,mdref} set filetype=markdown
  autocmd BufRead,BufNewFile *.{jscs,jshint,eslint} set filetype=json
  autocmd BufRead,BufNewFile *.{es6,js,tsx,jsx} set filetype=javascript
  autocmd BufRead,BufNewFile *.slim set filetype=slim
  autocmd BufRead,BufNewFile *.rb set filetype=ruby
  autocmd BufRead,BufNewFile *.scss set filetype=scss.css

  " autocmd BufWritePost *.rb silent exec "!rubocop-daemon exec " . expand("%") . " -- --auto-correct"
augroup END                                      " }}}
"
autocmd Filetype gitcommit setlocal spell textwidth=80
" }}}

"Keymappings {{{

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" LEADER SHORTCUTS {{{
  " change selection ' to "
vnoremap <leader>' :s/"/'/g<cr>
"    change selection " to '
vnoremap <leader>" :s/'/"/g<cr>
"   " FZF open buffers
nnoremap <leader>bl :Buffers<cr>
"   " focus left
nnoremap <leader>h <c-w>h
"   " focus down
nnoremap <leader>j <c-w>j
 " focus up
nnoremap <leader>k <c-w>k
 " focus right
nnoremap <leader>l <c-w>l
 " quit buffer without saving
nnoremap <leader>q :q!<CR>
 " FZF search pattern recursively from cwd
nnoremap <leader>sa :Ag<cr>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
 " FZF search tags
nnoremap <leader>v :silent vsplit<cr>
 " quick save
nnoremap <leader>w :silent w<CR>:echo 'saved!'<CR>
 " replace word under cursor, press . to repeat forwards
nnoremap <Leader>y :let @+=expand("#")<CR>:echo 'Relative path copied to clipboard.'<CR>
 " copy current buffer absolute path to clipboard
nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Absolute path copied to clipboard.'<CR>
 " suspend VIM and get a prompt. 'fg' to return
nnoremap <leader>z <c-z>
" }}}

" redo with capital U
nnoremap U <C-R>

" yank visually selected text to system clipboard
" vnoremap Y "+y

" easymotion at the press of a key
map J <Plug>(easymotion-j)
map K <Plug>(easymotion-k)
map L <Plug>(easymotion-lineforward)
map H <Plug>(easymotion-linebackward)

" exit insert mode without escape
inoremap jk <esc>

"stop that stupid window from popping up
map q: :q

" make y work like c & d
nnoremap Y y$

" make escape work like escape in terminals
tnoremap <esc> <C-\><C-n>

" Jump to the end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Copies what was just pasted
xnoremap p pgvy

" Common ruby-like regex for search using 'very magic mode'
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" easy navigate tabs
nnoremap gh gT
nnoremap gl gt

" change next inside ({["''"]})
nnoremap cn( f(ci(
nnoremap cN( F(ci(
nnoremap cn) f)ci)
nnoremap cN) F)ci)
nnoremap cn{ f{ci{
nnoremap cN{ F{ci{
nnoremap cn} f}ci}
nnoremap cN} F}ci}
nnoremap cn[ f[ci[
nnoremap cN[ F[ci[
nnoremap cn] f]ci]
nnoremap cN] F]ci]
nnoremap cn" f"ci"
nnoremap cN" F"ci"
nnoremap cn' f'ci'
nnoremap cN' F'ci'

" colors {{{
let g:palenight_terminal_italics=1
highlight Pmenu guibg=lightblue guifg=black
set background=dark
colorscheme onedark
" }}}

let g:coc_disable_startup_warning = 1

nnoremap <leader>f :GitFiles<CR>
