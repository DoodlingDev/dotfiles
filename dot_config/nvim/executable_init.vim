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
set completeopt=menuone,noinsert,noselect
" " }}}

" Plugins {{{
let g:plugin_dir = '~/.config/nvim/plugged'      " plugin control with Vim Plug
call plug#begin('~/.config/nvim/plugged')        " Begin Vim Plug

Plug 'drewtempelmeyer/palenight.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'                        " auto completion

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/galaxyline.nvim'

" Plug 'Raimondi/delimitMate'                      " auto pair delimiters
Plug 'cohama/lexima.vim'                         " smartly auto pair delimiters

Plug 'benizi/vim-automkdir'                      " automatically make dirs
" Plug 'ervandew/supertab'                         " better <tab>
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
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()                                  " }}}

luafile ~/.config/nvim/eviline.lua

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  require'lspconfig'.tsserver.setup{
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            --Disable virtual text
            virtual_text = false
          }
      )
    }
  }
  require'lspconfig'.solargraph.setup{
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            --Disable virtual text
            virtual_text = false
          }
      )
    }
  }

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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end
--
 vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
 vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
 vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
 vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    indent = { enable = true },
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = { "c", "rust" },  -- list of language that will be disabled
    },
  }

  local nvim_lsp = require('lspconfig')

--  local on_attach = function(client, bufnr)
    --require('completion').on_attach()

--    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--    -- Mappings
--    local opts = { noremap=true, silent=true }
--    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--
--    -- Set some keybinds conditional on server capabilities
--    if client.resolved_capabilities.document_formatting then
--        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--    elseif client.resolved_capabilities.document_range_formatting then
--        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--    end
--
--    -- Set autocommands conditional on server_capabilities
--    if client.resolved_capabilities.document_highlight then
--        require('lspconfig').util.nvim_multiline_command [[
--        :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--        :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--        :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--        augroup lsp_document_highlight
--            autocmd!
--            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--        augroup END
--        ]]
--    end

EOF



" Global variables {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:closetag_filenames = '*.html,*.js,*.xml'
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" }}}

command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \'ag '.shellescape(<q-args>).'.', 0,
      \ fzf#vim#with_preview(), <bang>0
      \)

" auto commands {{{
autocmd BufWritePre * :%s/\s\+$//e               " remove trailing whitespace
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics()

autocmd BufWritePre *.{jsx,es6,js,tsx} :Prettier
autocmd BufWritePost *.{jsx,es6,js,tsx} :e %
autocmd BufRead,BufNewFile *.vim set foldmethod=marker " viml folding

" flash a highlight for what selection was just yanked
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()

"autocmd BufEnter * lua require'completion'.on_attach()

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
 " search command palette
nnoremap <leader>sc :Commands<cr>
 " FZF search tags
nnoremap <leader>v :silent vsplit<cr>
 " quick save
nnoremap <leader>w :w<CR>
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
vnoremap <leader>y "+y

" easymotion at the press of a key
nmap J <Plug>(easymotion-j)
nmap K <Plug>(easymotion-k)

" moving front/end of line with home row
nnoremap L $
nnoremap H _

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
