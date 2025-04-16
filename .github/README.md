# dotfiles


## License

Licensed under GPLv2, see [LICENSE](LICENSE).

Side note: because the license file is not in the root folder, Github does not
automatically recognize it. This is
[by design](https://github.com/licensee/licensee/issues/250).


## Initial installation

### Install dotfiles

```
$ git clone --bare https://github.com/amhk/dotfiles $HOME/.dotfiles.git
$ alias dotfiles='git --git-dir="$HOME/.dotfiles.git" --work-tree="$HOME"'
$ dotfiles config status.showUntrackedFiles no
$ dotfiles checkout
$ dotfiles submodule update --init --recursive
```

### Install commonly used packages

Install the following packages

```
fzf ripgrep fd-find eza
```

### Install Rust

Install rustup from the system package manager, then run

```
$ rustup default stable
$ rustup component add rust-analyzer
```

### Install neovim (from source)

```
$ mkdir ~/src && $ cd ~/src
$ git clone https://github.com/neovim/neovim && $ cd neovim
$ rm -rf build && make -j128 CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/local" && make -j128 install
```


## Maintenance

Periodically run

```
$ dotfiles pull --recurse-submodules
$ dotfiles submodule update --remote
$ dotfiles add -u ~/.vim/pack/plugins/start && dotfiles commit -s

# update ~/.config/bash/git-*.sh from the git project
# update ~/.config/fzf/* from the fzf project
# update ~/.github/README.md (this file) with new timestamp
```

Latest maintenance performed on 2022-05-15.
