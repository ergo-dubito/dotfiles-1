# dotfiles Style Guide

## Table of Contents
* [Directory Structure](#directory-structure)
* [File Extensions](#file-extensions)
* [Language Rules and Code Formatting](#language-rules-and-code-formatting)
  * [General Rules](#general-rules)
  * [Bash](#bash)
  * [Make](#make)

---

## Directory Structure

Only files which are necessary for git and/or GitHub should reside in the root directory. This includes files such as a `.gitignore` or `README.md`.

All system-wide configurations that require symlinking should reside in a subdirectory. This keeps the repository view clean and concise while also accommodating GNU Stow's default behavior.

The general rule for subdirectory organization is to group analogous configurations and scripts under the corresponding subdirectory. 
* OS-specific files should reside in a folder such as `/macos` or `/linux`.
* OS-ambiguous files should reside in their own corresponding folders.
  * e.g. `.bash_profile` should reside in `/bash`, while `.vimrc` resides in `/vim`.

Hidden directories within the root `/dotfiles` folder serve no purpose and should be avoided.

## File Extensions

Unless being directly symlinked to the home directory, configuration files should *not* begin with a dot or period. Naturally, any files or folders utilized by git should retain their formatting.
* Acceptable: `.chunkwmrc`
  * This file will be symlinked directly to the home directory and is pertinently-named for chunkwm to properly function.
* Not acceptable: `/bash/dots/.aliases`
  * This file will not be symlinked; it is essentially a second-level file as it is only *sourced* by a file currently symlinked to the home directory (`.bash_profile`). Formatting this file only makes directory navigation more complicated.

File extensions are encouraged only in the event of ambiguity or lack of directory context. 
* e.g. a shell file should not contain a `.sh` extension if it resides in the `/bash` subdirectory. The language of the file is inferred.
* However, if a shell file is placed in `/macos`, a `.sh` should be included, as the language of the file is *not* inferred and declaration may be useful.

Executables should not have a file extension, since the knowledge of the language is not relevant when invoking an executable.

## Language Rules and Code Formatting

### General Rules
* Shell scripting
  * sh (dash) is encouraged for global or Linux-only shell scripts.
  * Bash is acceptable for macOS-only scripts
    * macOS symlinks `/bin/sh` to Bash v3.2.57
* Indentation and whitespace
  * 2 spaces. 
  * Avoid tabs unless necessary, such as prefixing Makefile recipes.
* Line length
  * 80 character maximum encouraged. Not strict.
* Alignment 
  * Alignment for the sake of legibility is strongly encouraged unless functionally inhibitive.
* Comments
  * Commenting is strongly encouraged for the sake of good documentation. 
  * Always err on the side of verbosity for comments.

### Bash
* She-bang
  * `#!/usr/bin/env bash`
  * She-bangs are generally encouraged, especially within files which have no file extension.

### Make
* The Makefile must accommodate GNU Make v3.81
  * This accommodates macOS, which only comes installed with v3.81 by default.
* Alignment
  * Variable assignments (`=`, `:=`, etc) should be aligned
    * This does not break any of Make's functionality.
* Indentation
  * Recipes **must** be prefixed with tab characters. 
