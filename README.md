dotfiles
========

After having my homedirs in subversion for years, moved this collection to Git in 2014 and standardised over all my machines.

To install:

```
mkdir ~/.dot
cd ~/.dot
clone <url>
cd dotfiles    # this takes you to the freshly cloned ~/.dot/dotfiles
sh install.sh  # install the files in the homedir
```

# Fix for shift+F6 in tmux (and screen probably)

In tmux, do `infocmp > screen-256color`. Add the line `kf16=\E[17;2~,` and compile the file with tic. This will result in `~/.terminfo/s/screen-256color` with the correct keycode for shift+F6. `.tmux.conf` needs the line `setw -g xterm-keys on` for it to register correctly.

# ~/.git_repos config file

The update_repos script takes the ~/.git_repos config file and lets you update and clone your projects automatically (or at least in a batch). In the example the first four repos are located in ~/workspace/projects/github, and the other two in workspace/projects/others and workspace/projects/private respectively; then the workspace and group are empty, so mydocs is cloned into the homedir. At the moment, only paths relative to the user's homedir are supported.

```
workspace=workspace/projects
group=github
git@github.com:aquatix/ns-api.git
git@github.com:aquatix/dotfiles.git
git@github.com:aquatix/dammit.git
git@github.com:aquatix/imagine.git

group=others
https://github.com/Azelphur/pyPushBullet.git

group=private
ssh://myserver/srv/git/privdotfiles.git

# Homedir as workspace:
workspace=
group=
ssh://myserver/srv/git/mydocs.git
```

# Interesting scripts

| ./bin/           | description                                                                             |
|------------------|-----------------------------------------------------------------------------------------|
| calibre_update   | Update (or install) ebook manager Calibre                                               |
| clean_mac_files  | Remove those DS_Store and other dirs                                                    |
| clean_project    | Remove compiled Python files, vim swp files                                             |
| clean_pyc        | Remove compiled Python files                                                            |
| fixpermissions   | chmod dirs to 755, files to 644                                                         |
| fixpictimestamps | Change file ctime to datetime from EXIF                                                 |
| fontupdate       | Update nerd-fonts; whole repo on server, link font files to ~/.local/share/fonts        |
| fuz              | Simple note-taking 'app' based on FZF and vim                                           |
| git_autosave     | Simple script to call from crontab or something to commit certain files in Git and push |
| git_clean        | Clean the Git tree                                                                      |
| sorter           | Sort files in newly created subdirectories, based on pre- or postfixes                  |
