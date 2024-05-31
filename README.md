dotfiles
========

After having my homedirs in subversion for years, moved this collection to Git [in 2014](https://github.com/aquatix/dotfiles/commit/18c02056381e7c44dd220f6cd54182ce3f040104) and standardised over all my machines (servers, desktops, laptops, phones, tablets).

To install:

```
mkdir ~/.dot
cd ~/.dot
clone <url>
cd dotfiles    # this takes you to the freshly cloned ~/.dot/dotfiles
sh install.sh  # follow the instructions and install the files in the homedir
```

Extra's:

[virtualfish](https://virtualfish.readthedocs.io/en/latest/install.html) for virtualenv(wrapper) integration in `fish` shell.


## Dependency on `fzf` and ripgrep `rg`

Both the shell configuration and vim make use of `fzf`. [fzf is a general-purpose command-line fuzzy finder](https://github.com/junegunn/fzf) and helps one 'grep' really fast through filenames. It's an alternative for the well-known `find`. Install it by cloning the repository and running the install script ([check the Installation notes too](https://github.com/junegunn/fzf#installation)).

[ripgrep, `rg`](https://github.com/BurntSushi/ripgrep) is a line-oriented search tool that recursively searches your current directory for a regex pattern while respecting your gitignore rules. Basically, a really fast (and clever) `grep`.

If your distribution does not provide a package, [get yours from the releases page](https://github.com/BurntSushi/ripgrep/releases) (there's a .deb for 64-bit systems).


## starship prompt

By default, the included fish shell configuration installs and uses the bobthefish prompt, but I have been using the [starship](https://starship.rs/) prompt [since November 2023](https://github.com/aquatix/dotfiles/commit/3836faaaf1e1207ee122eb3b72aa3cab27b4f1f7) and [configuration is included](https://github.com/aquatix/dotfiles/blob/master/.config/starship.toml).

To use, [install starship](https://starship.rs/#quick-install) and link the configuration to activate the configured prompt:

```bash
cd ~/.config
ln -s ../.dot/dotfiles/.config/starship.toml
```


## vim config

The [.vimrc](https://github.com/aquatix/dotfiles/blob/master/.vimrc) has a lot going on. [Find out more about my tweaks](https://dammit.nl/tag/vim.html) and use `:Maps` in vim itself to see key mappings

vim uses both `fzf` and `rg`, and also really likes having `ctags` (Exuberant Ctags) available.


## Fix for shift+F6 in tmux (and screen probably)

In tmux, do `infocmp > screen-256color`. Add the line `kf16=\E[17;2~,` and compile the file with tic. This will result in `~/.terminfo/s/screen-256color` with the correct keycode for shift+F6. `.tmux.conf` needs the line `setw -g xterm-keys on` for it to register correctly.


## ~/.git_repos config file

The `update_repos` script takes the `~/.git_repos` config file and lets you update and clone your projects automatically (or at least in a batch). In the example the first four repos are located in ~/workspace/projects/github, and the other two in workspace/projects/others and workspace/projects/private respectively; then the workspace and group are empty, so mydocs is cloned into the homedir. At the moment, only paths relative to the user's homedir are supported.

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


## Interesting scripts

| ./bin/           | description                                                                             |
|------------------|-----------------------------------------------------------------------------------------|
| calibre_update   | Update (or install) ebook manager Calibre                                               |
| clean_mac_files  | Remove those DS_Store and other dirs                                                    |
| clean_project    | Remove compiled Python files, vim swp files                                             |
| clean_pyc        | Remove compiled Python files                                                            |
| fixpermissions   | chmod dirs to 755, files to 644                                                         |
| fixpictimestamps | Change file ctime to datetime from EXIF using exiftool                                  |
| fontupdate       | Update nerd-fonts; whole repo on server, link font files to ~/.local/share/fonts        |
| fuz              | Simple note-taking 'app' based on FZF and vim                                           |
| git_autosave     | Simple script to call from crontab or something to commit certain files in Git and push |
| git_clean        | Clean the Git tree                                                                      |
| sorter           | Sort files in newly created subdirectories, based on pre- or postfixes                  |
| update_repos     | Update a bunch of Git repos at once, like all your project. Config with ~/.git_repos    |
