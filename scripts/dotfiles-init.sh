#!/bin/bash
#

DIR="$HOME/dotfiles"

git clone --bare git@github.com:Derrekito/dotfiles.git $DIR

git --git-dir="$DIR" --work-tree="$HOME" checkout

