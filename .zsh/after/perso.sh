alias g='git'

alias dm='docker-machine'

# export vars  for docker
dockerMachineEnvs () {
  eval $(docker-machine env machinename)
}
dockerMachineEnvs

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'


export CDPATH=$CDPATH:~/:/Volumes/Bonjour/dev

alias marina='sandbox-leaflet'

export PATH=$PATH:/Users/albandiguer/.local/bin
export PATH=$PATH:"$(brew --prefix mysql56)/bin"
# export DYLD_LIBRARY_PATH="$(brew --prefix mysql55)/lib":$DYLD_LIBRARY_PATH

export HOMEBREW_GITHUB_API_TOKEN='token'
