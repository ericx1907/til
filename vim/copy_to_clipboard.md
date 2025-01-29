There are two approaches to this problem.

## Install a version of vim that has clipboard support:
Use `vim --version | grep clipboard` to check if vim has clipboard. If it returns `-clipboard` that means it doe not have that. Either recompile vim or install a vim package that has clipboard support. For example, On Debin/Ubuntu: `sudo apt install vim-gtk3`.

Vim with clipboard support will have a special register named `*` corresponding to the system clipboard. In visual mode select text that need to be copied then `"*y`.After that the content can be pasted into any other program in the system.


## Use custom key map:

### Method 1
```
vnoremap <C-c> <Esc>`>a<CR><Esc>`<i<CR><Esc>vg_:w !xclip -i -selection c<CR><CR>kJJ
```
What this does is:  
| | |
| :--------------------------------- | :--------------- |  
| `<Esc>`                            | stop Visual mode |  
| `` `> ``                           | go to the end of the Visual area |
| `a<CR><Esc>`                       | break the line after the Visual area | 
| `` `< ``		                       | jump to the start of the Visual area |  
| `i<CR><Esc>`                       | break the line before the Visual area |  
| `vg_`				                       | select the the content you want to copy |   
|`:w !xclip -i -selection c<CR><CR>` | copy to system clipboard using xclip |  
| `kJJ`					                     | Join the lines back together |  

### Method 2
```vim
vnoremap <silent><C-c> "zy:call writefile(getreg('z', 1, 1), $HOME."/.vim/vim_clipboard")<CR>:call system("xclip -r -sel c $HOME/.vim/vim_clipboard")<CR>
```
In Method 1 despite the `g_` motion the `:w` command actually write the whole line including the new line charater at the end into the clipboard.[[1]] Method 2 does not have this issue. `"zy` ensures the content select by visual mode is yanked into the z register. the `writefile` internal function writes the context of z register into an external file. Then the xclip is called to read the file into the system clipboard. 

[1]: https://vimhelp.org/visual.txt.html#visual-examples
