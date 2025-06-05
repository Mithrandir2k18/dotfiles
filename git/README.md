# Dependencies

Uses [delta](https://github.com/dandavison/delta) as pager.

# Module git configs

Since the organization of repo folders and the information (email,
signing-keys, etc) for each repo may be different from machine to machine,
instead include a .gitconfig from the repos folder, then include settings for
specific repos (or subfolders of repos) using [conditional
includes](https://git-scm.com/docs/git-config#Documentation/git-config.txt-codegitdircode):

```ini
# file: ~/repos/.gitconfig
[includeIf "gitdir:~/repos/work/"]
    path = ~/repos/work/.gitconfig

...
```

```ini
# file: ~/repos/work/.gitconfig
[user]
    email = ...
    name = ...
    signingkey = ~/.ssh/workgitprivkey
[gpg]
    format = ssh

...
```
