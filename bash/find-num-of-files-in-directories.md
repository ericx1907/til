# Find Number of Files In Directories

Let us assume there is directory structure like this:

<pre>
.
├── bash
│   ├── find_num_of_files_in_directories.md
│   └── writing_to_a_binary_file.md
├── cron
│   └── cron_basic.md
├── git
│   ├── deleting_local_and_remote_branch.md
│   └── Rebasing_feature_branch_to_main_branch.md
├── vim
│   ├── copy_to_clipboard.md
│   └── syntax_group_under_cursor.md
├── venv
│   ├── bin
│   ├── include
│   ├── pyvenv.cfg
│   └── share
├── docs
│   └── index.md
├── mkdocs.yml
└── README.md
</pre>

The goal is to find the number of markdown files (\*.md) in `bash`, `cron`, `git` and
`vim` directories respectively but excluding `venv`, `docs` directories and files under
current root (./)

## Example 1:

```bash
$ find . -mindepth 2 \
\( -path "./venv/*" -o -path "./docs/*" \) \
-prune -o -name "*.md" -print | \
cut -d/ -f2 | \
uniq -c | \
sort -nr | \
awk 'tot = tot + $1; END{printf "%7i %s\n", tot, "."}'

2 bash
1 cron
2 git
2 vim
7 .
```

* The `-mindepth 2` will make sure not to apply tests or actions at level less than 2.
  This effectively exculde files under current root directory.

* The `\( -path "./venv/*" -o -path "./docs/*" \)` will test if entries returned by
  previous evaluation (-mindepth 2) match the pattern specified. Any entries under
  ./venv or(-o) ./docs directories will match and return `true`. Any entries not under
  ./venv and ./docs will not match and return `false`.

* If `true` entries matched will be pruned by `-prune` action. If `false` entries not
  matched will be tested further by `-name` with pattern `*.md` which returns all
  markdown files and then print to standard output one entry per line.

* `cut` will separate each line into parts with delimiter `/` and select the second part
  which is essentially the directory name under current roor `./`.

* `uniq -c` will merge adjacent matching line into one occurence and prefix each line
  with number of occurence.

* `sort -nr` will treat first field/column of each line as number and sort them in
  decending order.

* Finally the `awk` will sum up all number of occurence and print the sum on the last
  line.


## Example 2:

```bash
$ fd -g -t f -E 'docs' -E 'README.md' '*.md'

bash/find-num-of-files-in-directories.md
bash/writing-to-a-binary-file.md
cron/cron-basic.md
git/deleting-local-and-remote-branch.md
git/rebasing-feature-branch-to-main-branch.md
make/self-documenting-makefile.md
ripgrep/muiltiline-line-matching-using-ripgrep.md
ubuntu/package-management-using-apt-and-dpkg.md
vim/copy-to-clipboard.md
vim/syntax-group-under-cursor.md
```

`fd[find]` is used instead of `find`. `fd` respects `.gitignore` file by default and can
come handy when doing seartch in git repository. This example assumes that `/venv` is in
the .gitignore file. `fd` also ignores any hidden directory or files by default. `-E`
option can be used if more entries need to be excluded from searching.
