#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Utility functions
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

analyse_disk_usage() {
  sudo du -a $1 | sort -nr | head -n 15
}

duh() {
  du -csh
}

remove_dangling_containers() {
  docker images -q -f='dangling=true' | xargs docker rmi -f
}

list_port_usage() {
  sudo netstat -tulpn
}

why_lag() {
  watch "ps aux | sort -rk 3,3 | head -n 6"
}

catjson() {
  cat $1 | python -mjson.tool
}

_has_truecolor() {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s s s s s s s s s s s s s s s s;
    for (colnum = 0; colnum<256; colnum++) {
        r = 255-(colnum*255/255);
        g = (colnum*510/255);
        b = (colnum*255/255);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
  }'
}

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# aliases, plugins and exports
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ZSH=$HOME/.oh-my-zsh
# ZSH_THEME='josh' # PROTIP list themes: ~/.oh-my-zsh/tools/theme_chooser.sh -s
ZSH_THEME='muse' # PROTIP list themes: ~/.oh-my-zsh/tools/theme_chooser.sh -s
# ZSH_THEME='crunch' # PROTIP list themes: ~/.oh-my-zsh/tools/theme_chooser.sh -s

alias vi='vim .'
alias mvi='mvim .'
alias c='clear'

export ZSH
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"
export EDITOR='vim'
export CDPATH=$CDPATH:~/dev/
export PATH=./node_modules/.bin:./bin:~/dev/dotfiles/bin:~/npm-global/bin:/usr/local/bin:/usr/local/sbin:$PATH
export BON='/Volumes/Bonjour' # usb key
export CDPATH=$CDPATH:$BON/dev/os # fancy cd for workspaces

# list of oh-my-zsh plugins : ~/.oh-my-zsh/plugins/*
plugins=(
  aws
  bundler
  docker
  docker-compose
  git
  # git-flow
  go
  jira
  kubectl
  node
  npm
  osx
  postgres
  rails
  spring
  terraform
  virtualenv
  vundle
  yarn
  zsh
)

source $ZSH/oh-my-zsh.sh
# Include personal files, this is not indexed by git
for config_file (~/.zsh/after/*) source $config_file

# Faster keyboard
defaults write -g InitialKeyRepeat -int 11 # lowest via ux is 15
defaults write -g KeyRepeat -int 1 # lowest via ux is  2

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# enable RBENV/NODENV shims and autocompletion
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if _has rbenv; then
  eval "$(rbenv init -)"
fi

if _has nodenv; then
  eval "$(nodenv init -)"
fi

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# SSH agent loading
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Create agent/socket to hold private key
if [ ! -d /tmp/501 ]; then
  mkdir /tmp/501
  ssh-agent -a /tmp/501/ssh-agent.socket
fi

SSH_AUTH_SOCK=/tmp/501/ssh-agent.socket
export SSH_AUTH_SOCK

# Add private key to the auth agent
if [ -f ~/.ssh/id_rsa ]; then
  ssh-add ~/.ssh/id_rsa 2> /dev/null
fi

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# FZF config
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

# link fzf installed via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '
fi

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# PREVIEW README brew install pip && pip install grip if needed
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
alias preview_readme='grip'

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# change tab description for zshell
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Add italic support
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
{ infocmp -1 xterm-256color ; echo -e "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } > ~/.zsh/xterm-256color.terminfo
# { infocmp -1 xterm-256color ; echo -e "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } > xterm-256color.terminfo
tic ~/.zsh/xterm-256color.terminfo

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Python
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
eval "$(pyenv init -)"

alias k='kubectl'
