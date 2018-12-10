
alias dm='docker-machine'
# export vars  for docker
dockerMachineEnvs () {
  eval $(docker-machine env default)
}
dockerMachineEnvs


export CDPATH=$CDPATH:~/:/Volumes/Bonjour/dev

alias marina='sandbox-leaflet'

export PATH=$PATH:/Users/albandiguer/.local/bin
export PATH=$PATH:"$(brew --prefix mysql56)/bin"
# export DYLD_LIBRARY_PATH="$(brew --prefix mysql55)/lib":$DYLD_LIBRARY_PATH

export HOMEBREW_GITHUB_API_TOKEN='token'

weather() {
  curl wttr.in/sydney
}
