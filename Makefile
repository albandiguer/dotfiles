all: dev brew brew-deps dns apache-conf zsh tmux links install-vundle ycm fzf fonts linters

dev:
	cd ~ && mkdir dev || true

brew:
	xcode-select --install || true
	/usr/bin/ruby -e "$(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

zsh:
	cd ~/dev && sh -c "$(shell curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	chsh -s $(shell which zsh)
	ln -sf `pwd`/.zshrc ~/.zshrc || true

brew-deps:
	brew up
	brew install ack || true
	brew install cmake || true # for compiling YCM || true
	brew install ctags || true
	brew install git || true
	brew install nodenv || true
	brew install rbenv || true
	brew install ruby-build || true
	brew install the_silver_searcher || true
	brew install vim || true
	brew install watch || true
	brew install wget || true
	brew install tree || true
	brew install reattach-to-user-namespace || true
	# brew install selecta || true
	brew install ag || true # the silver searcher
	brew unlink ruby || true # vim installs its own ruby dep, we unlink to avoid conflicts with rbenv
	brew unlink node || true
	brew install grip || true # preview Markdown files
	brew cask install licecap || true
	brew cask install iterm2 || true
	brew cask install postman || true
	brew install tree || true # tree -L 2 .

aws:
	brew install awscli || true
	# see vault for credentials
	aws configure

irc:
	brew install irssi || true

tmux:
	brew install tmux || true
	ln -sf `pwd`/.tmux.conf ~/.tmux.conf || true
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	# open a tmux session and type CtrlB I to install plugins

vim-plug:
	 curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


ycm:
	# ycm use tsserver for js and ts files, see https://github.com/Valloric/YouCompleteMe
	npm install -g typescript || true
	cd ~/.vim/bundle/YouCompleteMe && chmod +x install.py && ./install.py --clang-completer

fzf:  # fuzzy search engine
	brew install fzf || true

dns:
	brew install dnsmasq || true
	rm /usr/local/etc/dnsmasq.conf
	ln -s `pwd`/dnsmasq.conf /usr/local/etc/ || true
	sudo ln -s `pwd`/resolver /etc || true
	sudo brew services restart dnsmasq # sudo because it needs to be in /Library/LaunchDaemons, see $brew services

apache-conf:
	# Inside /private/etc/apache2/httpd.conf
	# Uncomment Include /private/etc/apache2/extra/httpd-vhosts.conf
	# mod_proxy and mod_proxy_http
	# Uncomment LoadModule vhost_alias_module libexec/apache2/mod_vhost_alias.so
	sudo rm /private/etc/apache2/extra/httpd-vhosts.conf || true
	sudo ln -sf `pwd`/httpd-vhosts.conf /private/etc/apache2/extra/ || true
	sudo apachectl restart

links:
	ln -sf `pwd`/.config/nvim ~/.config/nvim || true
	ln -sf `pwd`/.gitconfig ~/.gitconfig || true
	ln -sf `pwd`/.gitignore ~/.gitignore || true
	ln -sf `pwd`/.gitmodules ~/.gitmodules || true

visual-studio-conf:
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false

fonts:
	brew tap caskroom/fonts && brew cask install font-iosevka

expose-local:
	# brew cask install ngrok
	# ngrok http 3003
	npm install -g localtunnel
	lt -p 3003

# This is global level linting, todo: dbl check overrides work per project
linters: prettier eslint tslint
	# npm i -g install-peerdeps

prettier:
	npm i -g prettier


eslint:
	npm i -g eslint
	npm i -g install-peerdeps
	# -S silent
	install-peerdeps eslint-config-airbnb -S -- -g
	install-peerdeps eslint-config-prettier -S -- -g
	ln -sf `pwd`/.eslintrc.json ~/.eslintrc.json

# For typescript I pick this over use eslint-config-typescript as I already
# have tslint (inc tsserver) for completion in ycm
tslint:
	npm i -g install-peerdeps
	npm i -g tslint
	install-peerdeps tslint-config-airbnb -S -- -g
	npm i -g tslint-config-prettier
	ln -sf `pwd`/tslint.json ~/tslint.json

tflint:
	brew tap wata727/tflint
	brew install tflint
# sql:
# 	gem install sqlint
# 	go get github.com/jackc/sqlfmt/


list-global-npm-deps:
	npm ls -g --depth=0

haskell:
	brew install haskell-stack
	stack install brittany # fixer
	stack install ghci # stack exec -- ghci

python:
	brew install pyenv
	pyenv install 3.7.0
	pip install --upgrade pip
	# pip install black # fixer, needs python 3.6+ : https://github.com/ambv/black
	# pip install flake8
	# pip install mypy # add types dynamically
	# use pyenv local command for that

generate-ssh-key:
	cd ~ && ssh-keygen -t rsa
	pbcopy < ~/.ssh/id_rsa.pub

.PHONY: sql tmux
