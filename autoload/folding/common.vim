" Inspired by "Learning Vim Script the Hard Way"
" http://learnvimscriptthehardway.stevelosh.com/chapters/49.html

function! folding#common#line_indent_level(lnum)
  return indent(a:lnum) / shiftwidth()
endfunction

function! folding#common#next_nonblank_line(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  while current <= numlines
    if getline(current) =~? '\v\S'
      return current
    endif
    let current += 1
  endwhile

  return -2
endfunction
