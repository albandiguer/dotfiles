symlinks:
	ln -sf `pwd`/.zshrc ~/.zshrc || true
	ln -sf `pwd`/.inputrc ~/.inputrc || true
	ln -sf `pwd`/.gitconfig ~/.gitconfig || true

nvim:
	brew install neovim

brew:
	xcode-select --install || true
	/usr/bin/ruby -e "$(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-deps:
	brew up
	brew install ack || true
	brew install git || true
	brew install awscli || true
	brew install neovim || true
	brew install wget || true
	brew install tree || true
	brew install reattach-to-user-namespace || true
	brew cask install licecap || true
	brew cask install postman || true
	brew install tree || true # tree -L 2 .
	brew install fzf || true
	brew install tldr || true
	brew tap caskroom/fonts && brew cask install font-iosevka || true

# TODO move that into docker
# aws:
# 	brew install awscli || true
# 	# see vault for credentials
# 	aws configure
