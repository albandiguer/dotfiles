all: dev brew brew-deps oh-my-zsh links vim-plugins

dev:
	cd ~ && mkdir dev || true
	
brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

oh-my-zsh:
	cd ~/dev && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	
brew-deps:
	brew install git
	brew install tmux
	brew install ack
	brew install ctags
	brew install rbenv
	brew install ruby-build
	brew install wget
	brew install watch
	brew install the_silver_searcher
	brew install vim

vim-plugins:
	mkdir ~/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall
	cd ~/.vim/bundle/command-t/ruby/commant-t && ruby extconf.rb && make
	cd ~/.vim/bundle/YouCompleteMe
	chmod -x install.sh && ./install.sh

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
	ln -sf `pwd`/.zshrc ~/.zsrhc || true 
	ln -sf `pwd`/.gemrc ~/.gemrc || true 
	ln -sf `pwd`/.tmux.conf ~/.tmux.conf || true 
	ln -sf `pwd`/.ctags ~/.ctags || true 
	ln -sf `pwd`/.jshintrc ~/.jshintrc || true 


