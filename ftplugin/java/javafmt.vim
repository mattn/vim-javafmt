if !executable('java')
  finish
endif

if !exists("g:javafmt_program")
  let g:javafmt_program = 'java -jar ' . globpath(&rtp, 'lib/google-java-format*.jar')
endif

if !exists("g:javafmt_options")
  let g:javafmt_options = ''
endif

function! s:javafmt(...) abort
  if empty(globpath(&rtp, 'lib/google-java-format*.jar'))
    echohl ErrorMsg
    redraw
    echomsg "Please download google-java-format and place in .vim/lib"
    echohl None
    return
  endif
  if len(a:000) == 0
    let lines = system(g:javafmt_program . ' ' . g:javafmt_options . ' - ' . expand('%'))
  else
    let files = []
    for arg in a:000
      let files += split(expand(arg), "\n")
    endfor
    let files = map(files, 'shellescape(expand(v:val))')
    let lines = system(g:javafmt_program . ' ' . g:javafmt_options . ' ' . join(files, ' '))
  endif
  if v:shell_error == 0
    let pos = getcurpos()
    silent! %d _
    call setline(1, split(lines, "\n"))
    call setpos('.', pos)
  else
    cexp lines
    cwindow
  endif
endfunction

command! -nargs=* -complete=file JavaFmt call <SID>javafmt(<f-args>)
