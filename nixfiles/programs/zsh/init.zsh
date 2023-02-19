
# Add local directory ./node_modules/.bin
# + a global directory for `npm i -g` https://matthewrhone.dev/nixos-npm-globally
export PATH="./bin:./node_modules/.bin:$HOME/.bin:$HOME/.npm-packages/bin:$PATH";
export NODE_PATH=~/.npm-packages/lib/node_modules

source <(kubectl completion zsh)
if [ -f minikube ]; then
source <(minikube completion zsh)
fi
if [ -f gh ]; then
source <(gh completion -s zsh)
fi

alias nixsearch="nix search nixpkgs"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/albandiguer/dev/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/Users/albandiguer/dev/miniforge3/etc/profile.d/conda.sh" ]; then
	. "/Users/albandiguer/dev/miniforge3/etc/profile.d/conda.sh"
	else
	export PATH="$PATH:/Users/albandiguer/dev/miniforge3/bin"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias condaenvs="conda env list"

alias prettyjson="python3 -mjson.tool"
# use: conda activate mlp | base to activate an environment
# use: conda deactivate to deactivate environment

# not closing shell on ctrl+d
setopt ignore_eof

# todoist
alias td="todoist"
alias tdl="todoist l"
alias tda="todoist a"

# heroku autocomplete setup
# infered from instructions given typing: heroku autocomplete
export HEROKU_AC_ZSH_SETUP_PATH=/Users/albandiguer/Library/Caches/heroku/autocomplete/zsh_setup;
test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
# export HEROKU_ORGANIZATION=<org>

alias devbox="ssh ubuntu@51.68.38.158 -p 2222"

alias dk="docker"
alias dkc="docker-compose"

# psql/libpq PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# function to rebase current branch on top of master, finding common ancestor as starting point
function gri() {
git merge-base origin/master HEAD|xargs git rebase -i
}