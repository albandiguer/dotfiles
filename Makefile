all: dev brew brew-deps dns-config zsh links vim-plugins

dev:
	cd ~ && mkdir dev || true
	
brew:
	xcode-select --install || true
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

zsh:
	# oh my zsh
	cd ~/dev && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	chsh -s $(which zsh)

brew-deps:
	brew up
	brew install ack || true 
	brew install cmake # for compiling YCM || true 
	brew install ctags || true 
	brew install dnsmasq || true 
	brew install git || true
	brew install nodenv || true 
	brew install rbenv || true 
	brew install ruby-build || true 
	brew install the_silver_searcher || true 
	brew install tmux || true 
	brew install vim || true 
	brew install watch || true 
	brew install wget || true 

vim-plugins:
	mkdir ~/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall
	cd ~/.vim/bundle/command-t/ruby/commant-t && ruby extconf.rb && make
	cd ~/.vim/bundle/YouCompleteMe
	chmod -x install.py && ./install.py
	cd ~/.vim/bundle/tern_for_vim && npm install

dns-config:
	cp /usr/local/opt/dnsmasq/dnsmasq.conf.example /usr/local/etc/dnsmasq.conf

links:
	ln -sf `pwd`/.ackrc ~/.ackrc || true 
	ln -sf `pwd`/.aprc ~/.aprc || true 
	ln -sf `pwd`/.editrc ~/.editrc || true 
	ln -sf `pwd`/.gemrc ~/.gemrc || true 
	ln -sf `pwd`/.vimrc ~/.vimrc || true 
	ln -sf `pwd`/.vim ~/.vim || true 
	ln -sf `pwd`/.pryrc ~/.pryrc || true 
	ln -sf `pwd`/.gitconfig ~/.gitconfig || true 
	ln -sf `pwd`/.gitignore ~/.gitignore || true 
	ln -sf `pwd`/.zshrc ~/.zshrc || true 
	mkdir -p ~/.zsh/after
	ln -sf `pwd`/.gemrc ~/.gemrc || true 
	ln -sf `pwd`/.tmux.conf ~/.tmux.conf || true 
	ln -sf `pwd`/.ctags ~/.ctags || true 
	ln -sf `pwd`/.jshintrc ~/.jshintrc || true 
	ln -sf `pwd`/.rspec ~/.rspec || true 
	ln -sf `pwd`/.babelrc ~/.babelrc || true 
	ln -sf `pwd`/.inputrc ~/.inputrc || true 


