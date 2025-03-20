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

Example 1:

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
  matched will be tested by `-name` with pattern `*.md` which returns all markdown files
  and then print to standand output one entry per line.
