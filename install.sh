#!/bin/zsh

# TODO finish
# symlink .vim directory
# Do something for .zsh/after/ files ?

echo 'Magic starting'

DIR=~/dev/dotfiles
for file in $DIR/.* 
do
    # for every file which is not a directory 
    b=$(basename $file) 
    if [ -f $file -a $b != ".gitmodules" ]
    then
        echo "Symlinking: ln -s $file ~/$b"
        ln -s $file ~/$b
    fi
done

mkdir -p ~/.zsh/after