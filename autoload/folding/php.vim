let s:php_folding_block_type = ""
function! folding#php#line_fold_level(lnum)
  let thisline = getline(a:lnum)
  let fold_level = "="
  let prev_folding_block_type = s:php_folding_block_type

  if thisline =~? '\v^\s*/\*'
    let s:php_folding_block_type = "comment"
  elseif thisline =~? '\v^\s*#'
    let s:php_folding_block_type = "comment"
  elseif thisline =~? '\v^\s*class\s+'
    let s:php_folding_block_type = "class"
  elseif thisline =~? '\v^\s*(public|protected|private|)\s+function\s+'
    let s:php_folding_block_type = "function"
  else
    let s:php_folding_block_type = ""
  endif

  if s:php_folding_block_type != "" && prev_folding_block_type != "comment"
    let this_indent = folding#common#line_indent_level(a:lnum)
    let next_indent = folding#common#line_indent_level(folding#common#next_nonblank_line(a:lnum))
    if next_indent <= this_indent
      let fold_level = "="
    else
      let fold_level = ">" . next_indent
    endif
  endif

  return fold_level
endfunction

function! folding#php#fold_text()
  let foldsize = (v:foldend - v:foldstart)
  return getline(v:foldstart) . ' (' . foldsize . ' lines)'
endfunction
