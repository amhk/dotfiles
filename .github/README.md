# dotfiles


## License

Licensed under GPLv2, see [LICENSE](LICENSE).

Side note: because the license file is not in the root folder, Github does not
automatically recognize it. This is
[by design](https://github.com/licensee/licensee/issues/250).


## Installation

```
$ git clone --bare https://github.com/amhk/dotfiles $HOME/.dotfiles.git
$ alias dotfiles='git --git-dir="$HOME/.dotfiles.git" --work-tree="$HOME"'
$ dotfiles config status.showUntrackedFiles no
$ dotfiles checkout
$ dotfiles submodule update --init --recursive
```
