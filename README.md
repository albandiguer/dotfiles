# Alban's Dotfiles

This is my compilation of useful tools and preferences to work with vim, tmux and iterm.

## Setup a machine


- Create a dir ~/dev
- Install Iterm2
- Install Tmux
- Install Brew
- Install oh-my-zsh
- symlink .dotfiles
- add start_tmux_session.sh to the command to launch into iTerm2 preferences
- run ```:PluginInstall``` from vim to launch the vundle install
- run ```:PluginUpdqte```to update modules
- Compile vim ```brew install https://raw.githubusercontent.com/Homebrew/homebrew/master/Library/Formula/vim.rb```
- Recompile command-t plugin 

```
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb 
make
```
- create your personal zsh (one per project ?) config files into ~/.zsh/after/
