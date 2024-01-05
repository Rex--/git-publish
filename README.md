git-publish
===========
Publish to remote directories using `git` + `ssh`.

`git-publish` provides a way to easily sync a directory to a remote server. It
does this by pushing to a remote git repository over a ssh connection, both of
which are readily available on most linux based servers. Checkout the
documentation in the `docs/` folder for more information.


Install
-------
Simply place the `git-publish` script somewhere on your $PATH if you would like
to use the `git publish` sub-command. Otherwise, mark the script as executable
and run it.

An install script is provided which makes the above process mostly automatic
with a single prompt for the installation path. It can be run with either
`make install` or by executing the script `./install.sh`.


Usage
-----
For usage information, checkout the man page in the docs/ folder with
`man -l docs/git-publish.1` or if you've installed git-publish using the
provided script you can use `man git-publish` from anywhere.


Resources
---------
- Github: https://github.com/Rex--/git-publish
- Docs: https://rex.mckinnon.ninja/git-publish


Copying
-------
Copyright (C) 2022-2024 Rex McKinnon \
This software is available for free under the permissive University of
Illinois/NCSA Open Source License. See the LICENSE file for full details.
