" ╔═╗┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
" ╠╣ │ │││││   │ ││ ││││└─┐
" ╚  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

fun! EmptyReg()
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfun

function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

function! ToggleWrap()
 if (&wrap == 1)
   set nowrap
   echo "WRAP OFF{}"
 else
   set wrap
   echo "WRAP ON"
 endif
endfunction

let g:last_pos = 0
function s:Cursor_Moved()
  let cur_pos = winline()
  if g:last_pos == 0
    set cul
    let g:last_pos = cur_pos
    return
  endif
  let diff = g:last_pos - cur_pos
  if diff > 6 || diff < -6
    set cul
  else
    set nocul
  endif
  let g:last_pos = cur_pos
endfunction

" ╔═╗┌┬┐┌┬┐┌─┐
" ║  │││ ││└─┐
" ╚═╝┴ ┴─┴┘└─┘
augroup AUTO_COMMANDS
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
augroup END

augroup PYTHON
  autocmd!
  autocmd FileType python nnoremap <buffer> <C-e> :w<Cr> :exec '!python3' shellescape(@%, 1)<CR>
  autocmd BufWritePre *.py :Isort
  autocmd BufWritePre *.py :Autoformat
augroup END

augroup HIGHLIGHT
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:Cursor_Moved()
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 69})
augroup END