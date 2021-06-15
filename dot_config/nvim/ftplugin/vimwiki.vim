" vimwiki to html is not supported for md syntax
" nmap <leader>wh <Plug>Vimwiki2HTML

" create and follow link
nmap <CR> <Plug>VimwikiFollowLink

" create and follow link into new vsplit
nmap <S-CR> <Plug>VimwikiVSplitLink

" go back to previously viewed wiki page
nmap <Backspace> <Plug>VimwikiGoBackLink

" rename current wiki page
nmap <leader>wr <Plug>VimwikiRenameFile

" open previous diary day
nmap <leader>wy <Plug>VimwikiDiaryPrevDay

" open previous diary day
nmap <leader>wt <Plug>VimwikiDiaryNextDay

" table entry navigation
imap <leader>l <c-o>:call<space>vimwiki#tbl#goto_next_col()<cr>
imap <leader>h <c-o>:call<space>vimwiki#tbl#goto_prev_col()<cr>

let g:typeover_mode_on = 0

function NextTypeoverWord()
  call feedkeys("hi")
  " if g:typeover_mode_on == 0
  "   call feedkeys("hi")
  "   call feedkeys("i\<space>")
  " else
  "   call feedkeys("\<esc>lwviwc")
  " endif
endfunction

function ToggleTypeoverMode()
  if g:typeover_mode_on == 0
    let g:typeover_mode_on = 1
  else
    let g:typeover_mode_on = 0
  endif
endfunction
