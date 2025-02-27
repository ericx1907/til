To find out the syntax group the object under cursor belongs to:

```viml
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
```

This creates a function you can call on vim command-line 

Simple one-liner of the above function if you dont want to clutter your vimrc:

```viml
let s = synID(line('.'), col('.'), 1) | echo synIDattr(s, 'name') . ' -> ' . synIDattr(synIDtrans(s), 'name')
```
