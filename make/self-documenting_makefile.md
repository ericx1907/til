The following is a simpler solution that does not require defining user functions or aggregating help text away from the rules they document:

```makefile
# This is a regular comment, that will not be displayed

## ----------------------------------------------------------------------
## This is a help comment. The purpose of this Makefile is to demonstrate
## a simple help mechanism that uses comments defined alongside the rules
## they describe without the need of additional help files or echoing of
## descriptions. Help comments are displayed in the order defined within
## the Makefile.
## ----------------------------------------------------------------------

help:     ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

build:    ## Build something.

install:  ## Install something.

deploy:   ## Deploy something.

format:   ## Help comments are display with their leading whitespace. For
          ## example, all comments in this snippet are aligned with spaces.
```

Running `make` or `make help` results in the following:

```
----------------------------------------------------------------------
This is a help comment. The purpose of this Makefile is to demonstrate
a simple help mechanism that uses comments defined alongside the rules
they describe without the need of additional help files or echoing of
descriptions. Help comments are displayed in the order defined within
the Makefile.
----------------------------------------------------------------------
help:     Show this help.
build:    Build something.
install:  Install something.
deploy:   Deploy something.
format:   Help comments are display with their leading whitespace. For
          example, all comments in this snippet are aligned with spaces.
```

The @ symbol before `sed` command is a command prefix that prevent command from echoing out to the console.
The sed command will substitute "## " with nothing EXCEPT for lines which contains "@sed" then print them out.

[Credit](https://stackoverflow.com/questions/3477292/what-do-and-do-as-prefixes-to-recipe-lines-in-make)
