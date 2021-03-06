<p align="center" >
  <img src="header.png" alt="dotfiles" title="dotfiles">
</p>

## About

This repository contains files for configuring my Terminal environment and other various macOS settings. See [Github does dotfiles](https://dotfiles.github.io) for more info

## Table of Contents
* [Installation](#installation)
* [Usage](#usage)
* [How it Works](#how-it-works)
  * [Makefile](#makefile)
  * [Symlinks with GNU Stow](#symlinks)
  * [Bash](#bash)
  * [Vim](#vim)
  * [Window Management](#window-management)

---

## Installation

```bash
$ curl get.darryl.sh/dotfiles | sh
```

The SHA-256 checksum of the script is `5e235d8c44c5f3eab3f04d999281349cde47b34d26328293b66b4325f815de62`. You can verify this before downloading by running:

```bash
$ curl get.darryl.sh/dotfiles | shasum -a 256
```

The `curl` method will install everything automatically. This is really useful for quickly setting up a new machine. See the [repository](https://github.com/rootbeersoup/get.darryl.sh) for more detailed information on what the script does.

You can also manually clone the repository and invoke the `Makefile`

```bash
$ git clone --recursive https://github.com/rootbeersoup/dotfiles.git
$ cd dotfiles
$ make
```

The `--recursive` flag clones all included submodules. This option is not fully necessary; the `Makefile` will clone the submodules if they are missing.

## Usage

Command | Function
--------|---------
`make`      | Full installation and configuration
`make brew` | Homebrew maintenance

## How it Works

### Makefile

* Runs [`/macos/brew/init.sh`](https://github.com/rootbeersoup/dotfiles/blob/master/macos/brew/init.sh), which installs [Homebrew](https://brew.sh) and maintains all packages defined in the Brewfile (`brew bundle`, `update`, `upgrade`, `cleanup`).
* Sets Homebrew-installed Bash (4.4+) as the default shell
* Updates macOS and configures preferred system defaults defined in [`/macos/defaults.sh`](https://github.com/rootbeersoup/dotfiles/blob/master/macos/defaults.sh)
* Configures [chunkwm](https://github.com/koekeishiya/chunkwm) and [skhd](https://github.com/koekeishiya/skhd) to run at system startup
* Creates necessary symlinks via [GNU Stow](https://www.gnu.org/software/stow/)
* Runs [`/macos/duti/set.sh`](https://github.com/rootbeersoup/dotfiles/blob/master/macos/duti/set.sh), which sets defaults handlers/programs for file extensions via [duti](http://duti.org).

### Symlinks

All necessary symlinks ( [`.bash_profile`](https://github.com/rootbeersoup/dotfiles/blob/master/bash/.bash_profile), [`.vimrc`](https://github.com/rootbeersoup/dotfiles/blob/master/vim/.vimrc), among others) are managed with GNU Stow (installed with Homebrew). Files you wish to be symlinked to the home directory need to be placed in a folder within `~/dotfiles`. Using the `stow` command from the `~/dotfiles` directory will symlink the contents of the folder you choose (`/bash`, `/vim`, etc) to the grandparent directory, which is wherever the `/dotfiles` folder is contained.

Assuming you clone the dotfiles repository in your home directory, executing the commands:

```bash
$ cd dotfiles
$ stow bash
```
will symlink the contents of [`/bash`](https://github.com/rootbeersoup/dotfiles/blob/master/bash/) to the home directory.

You can use the `stow` command anytime you add a new file to a folder you wish to symlink directly to the home directory. This can all be done without Stow using the `ln -s` command, but I find GNU Stow with folder management to be cleaner and easier to maintain.

### Bash

`.bash_profile` automatically sources configurations defined in the files contained in the [`/bash/dots`](https://github.com/rootbeersoup/dotfiles/blob/master/bash/dots/) folder. Any changes to any existing file, as well as any new files in the `/bash/dots` folder will be loaded into the shell upon opening a new Terminal window or [reloading](https://github.com/rootbeersoup/dotfiles/blob/db902b9ac0c466d09672f58549bff4107ba53861/dots/aliases#L4) the `.bash_profile`.

### Vim

My vim plugin manager of choice is [Pathogen](https://github.com/tpope/vim-pathogen). The `pathogen.vim` file is autoloaded and invokes the plugins in the `/vim/bundle` folder via a single line in my `.vimrc`:

```
execute pathogen#infect()
```

Vim plugins are currently contained as git submodules, to keep the remote repository slimmer. The extraneous `git submodule init` and `git submodule update` commands are handled by the `Makefile`.

### Window Management

chunkwm and skhd are configured via `.chunkwmrc` and `.skhdrc` respectively. Both are located in the `/macos` folder and symlinked to the home directory with `stow macos`.
