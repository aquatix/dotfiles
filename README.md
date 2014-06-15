dotfiles
========

After having my homedirs in subversion for years, move to Git.

```
sh install.sh
```

# Fix for shift+F6 in tmux (and screen probably)

In tmux, do `infocmp > screen-256color`. Add the line `kf16=\E[17;2~,` and compile the file with tic. This will result in `~/.terminfo/s/screen-256color` with the correct keycode for shift+F6.
