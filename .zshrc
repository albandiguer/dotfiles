# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="steeef"
ZSH_THEME="af-magic"

# Unbreak broken, non-colored terminal                                                                                                                                                                 
# export TERM='screen-256color'  
# alias tmux="tmux -2"
alias duh='du -csh'                                                             
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"                                        
export GREP_OPTIONS="--color"
alias vi='vim .'
alias s='screen'
alias sr='screen -r'
alias j='jobs'
alias notes='vim +RecentNotes'
alias c='clear'
alias o='mvim'

function count_inodes {
    for i in `find . -type d `; do echo `ls -a $i | wc -l` $i; done | sort -n
}
# Ruby related
export RSPEC_FAIL_FAST='1'

#redis restart
alias redis-server-start='redis-server /usr/local/etc/redis.conf'

export EDITOR='vim'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rails git postgres virtualenv)

# To enable shims and autocompletion add to your profile
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

source $ZSH/oh-my-zsh.sh

# Create agent/socket to hold private key
if [ ! -d /tmp/501 ]; then
  mkdir /tmp/501
  ssh-agent -a /tmp/501/ssh-agent.socket
fi

SSH_AUTH_SOCK=/tmp/501/ssh-agent.socket
export SSH_AUTH_SOCK

# Add private key to the auth agent
if [ -d ~/.ssh/id_rsa ]; then
  ssh-add ~/.ssh/id_rsa
fi

CDPATH=$CDPATH:~/dev/


# Include personal files, this is not indexed by git
for config_file (~/.zsh/after/*) source $config_file

# Customize to your needs...
export PATH=./bin:~/dev/dotfiles/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:$PATH:/usr/X11/bin

# Selecta magic commands 'brew install selecta'
p() {
    cd $(find ~/dev -maxdepth 1 -type d | selecta)
}

# brew install pip && pip install grip if needed
alias preview_readme='grip'
