setlocal foldmethod=expr
setlocal foldexpr=folding#php#line_fold_level(v:lnum)
setlocal foldtext=folding#php#fold_text()
