dotfiles
========

After having my homedirs in subversion for years, move to Git.

```
mkdir ~/.dot
clone --no-checkout <url>
git config core.worktree="../../../"
git checkout master
cd
sh install.sh
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
