`dpkg` is the low level package manager for Debain (Ubuntu is a linux distribution based on Debian). `dpkg` is called by `apt-get/apt-cache` at some point. `apt` provides the same functionality as `apt-get` and `apt-cache` but is more user-friendly and more suitable for interactive use by default.

To update, upgrade system packages:
```{bash}
sudo apt update && sudo apt upgrade -y && sudo apt autoremove
```
The `&&` is used to chain commands together. Each command executes in turn, provided that the previous command has given a return value of *true*(zero). At the first *false*(non-zero) return, the command chain terminates. The `-y` flag tells the command to proceed without generating the prompt to ask user yes/no. The `autoremove` command removes the automatically installed dependency packages that is no longer being used.

To find which package a file belongs to:

```{bash}
dpkg -S `which less`
```

Here the `` ` ` `` is a command subsitution which excutes the command and return the result in double backticks first.

To list all files a package contains (including their full path):

```{bash}
dpkg -L $(which less)
```

The '$()' is another way of doing command substitution.
