
# Add local directory ./node_modules/.bin
# + a global directory for `npm i -g` https://matthewrhone.dev/nixos-npm-globally
export PATH=\
./bin:\
./node_modules/.bin:\
/opt/homebrew/bin:\
$HOME/.npm-packages/bin:\
$PATH;

export LIBRARY_PATH=\
/opt/homebrew/lib:\
$LIBRARY_PATH;

export NODE_PATH=~/.npm-packages/lib/node_modules
# export EDITOR=nvim

# Autocompletions
source <(kubectl completion zsh)
# Minikube
if [ -f minikube ]; then
	source <(minikube completion zsh)
fi
# Github
source <(gh completion -s zsh)
# Buildpack https://buildpacks.io/docs/tools/pack/cli/pack_completion/
. $(pack completion --shell zsh)
# Rbenv
eval "$(rbenv init - zsh)"
# Graphite
. <(gt completion)

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

# use: conda activate mlp | base to activate an environment
# use: conda deactivate to deactivate environment

# not closing shell on ctrl+d
setopt ignore_eof

# aliases
alias td="todoist"
alias dk="docker"
alias dkc="docker-compose"
alias condaenvs="conda env list"
alias prettyjson="python3 -mjson.tool"
alias nixsearch="nix search nixpkgs"

