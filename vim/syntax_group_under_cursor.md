To find out which syntax group the object under cursor belongs to:

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

To list a paticular highlight group in vim:

```viml
filter LineNr hi[ghlight]
```

To show which file is the last file that executes a certain command:

```
verbose hi[ghlight] LineNr
```
