runtime! autoload/folding/php.vim

" Tests are read-only so only load the fixture file once.
new 't/fixtures/drupal7-form.inc'

describe 'folding#php#line_fold_level'

  it '[drupal7-form] top-level comments have fold level 1'
    Expect folding#php#line_fold_level(0) == 0
  end

end

close!
