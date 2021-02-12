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

yah() {
  open "https://finance.yahoo.com/quote/$1"
}


listGlobalNpmPackages() {
	npm ls -g --depth=0
}

generateSSHKey() {
	cd ~ && ssh-keygen -t rsa
	pbcopy < ~/.ssh/id_rsa.pub
}


#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Some config
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
alias vi='nvim .'
alias vim="nvim"
alias c='clear'
alias g='git'
export EDITOR='vim'
export CDPATH=$CDPATH:~/dev/


# https://gist.github.com/albandiguer/53cae4d6e5d59721d4e1d34dc56e5505
defaults write org.macosforge.xquartz.X11.plist nolisten_tcp 0
export DISPLAY=`HOSTNAME`:0
xhost `hostname` > /dev/null # host allowed to connect to x serverx26
# TODO in xquartz, enable Update pasteboard immediately when new text is selected
# Run a work container, mount targeted directory
# TODO add another parameter to know the kind of language used - node, web, haskell...
# default to albandiguer/nvim:latest
code() {
  case $2 in
    js)
      IMAGE=albandiguer/nodejs-dev:erbium
      ;;
    *)
      IMAGE=albandiguer/nvim:latest
      ;;
  esac

  docker run -ti --rm \
          -v /var/run/docker.sock:/var/run/docker.sock \
          -v $(which docker):$(which docker) \
          -v $(pwd)/$1:/home/albandiguer/$1 \
          -v ~/.ssh:/home/albandiguer/.ssh \
          -v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
          -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
          -v /tmp/tmux-resurrect:/tmp/tmux-resurrect \
          -e DISPLAY=$DISPLAY \
          -v /tmp/.X11-unix:/tmp/.X11-unix \
          $IMAGE
}

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# FZF config
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
# Faster keyboard
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
defaults write -g InitialKeyRepeat -int 11 # lowest via ux is 15
defaults write -g KeyRepeat -int 1 # lowest via ux is  2
# https://gist.github.com/albandiguer/53cae4d6e5d59721d4e1d34dc56e5505
defaults write org.macosforge.xquartz.X11.plist nolisten_tcp 0
export DISPLAY=`HOSTNAME`:0
xhost `hostname` > /dev/null # host allowed to connect to x serverx26
# TODO in xquartz, enable Update pasteboard immediately when new text is selected
# Run a work container, mount targeted directory
# TODO add another parameter to know the kind of language used - node, web, haskell...
# default to albandiguer/nvim:latest

# link fzf installed via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
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


# TODO add function for aws cli
#
