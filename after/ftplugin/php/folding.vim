" Inspired by "Learning Vim Script the Hard Way"
" http://learnvimscriptthehardway.stevelosh.com/chapters/49.html

function! PHPFoldingIndentLevel(lnum)
  "return indent(a:lnum) / shiftwidth()
  return indent(a:lnum) / 4
endfunction

function! PHPFoldingNextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  while current <= numlines
    if match(getline(current), '\v\S')
      return current
    endif
    let current += 1
  endwhile

  return -2
endfunction

let s:php_folding_block_type = ""
function! PHPFoldingFoldLevel(lnum)
  let thisline = getline(a:lnum)
  let fold_level = "="
  let prev_folding_block_type = s:php_folding_block_type

  if match(thisline, '\v^\s*/\*')
    let s:php_folding_block_type = "comment"
  elseif match(thisline, '\v^\s*#')
    let s:php_folding_block_type = "comment"
  elseif match(thisline, '\v^\s*class\s+')
    let s:php_folding_block_type = "class"
  elseif match(thisline, '\v^\s*(public|protected|private|)\s+function\s+')
    let s:php_folding_block_type = "function"
  else
    let s:php_folding_block_type = ""
  endif

  if s:php_folding_block_type != "" && prev_folding_block_type != "comment"
    let this_indent = PHPFoldingIndentLevel(a:lnum)
    let next_indent = PHPFoldingIndentLevel(PHPFoldingNextNonBlankLine(a:lnum))
    if next_indent <= this_indent
      let fold_level = "="
    else
      let fold_level = ">" . next_indent
    endif
  endif

  return fold_level
endfunction

"setlocal foldmethod=expr
"setlocal foldexpr=PHPFoldingFoldLevel(v:lnum)
setlocal foldmethod=indent

function! PHPFoldingFoldText()
  let foldsize = (v:foldend - v:foldstart)
  return getline(v:foldstart) . ' (' . foldsize . ' lines)'
endfunction

setlocal foldtext=PHPFoldingFoldText()
