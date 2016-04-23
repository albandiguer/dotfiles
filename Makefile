dev:
	mkdir dev
	
brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

oh-my-zsh:
	cd ~/dev && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	
brew-deps:
	brew install git
	brew install tmux

vim-plugins:
	vim +PluginInstall
	cd ~/.vim/bundle/command-t/ruby/commant-t && ruby extconf.rb && make

links:
	ln -s .ackrc ~/.ackrc || true 
	ln -s .aprc ~/.aprc || true 
	ln -s .editrc ~/.editrc || true 
	ln -s .gemrc ~/.gemrc || true 
	ln -s .vimrc ~/.vimrc || true 
	ln -s .vim ~/.vim || true 
	ln -s .pryrc ~/.pryrc || true 
	ln -s .gitconfig ~/.gitconfig || true 
	ln -s .gitignore ~/.gitignore || true 
	ln -s .zshrc ~/.zsrhc || true 
	ln -s .gemrc ~/.gemrc || true 


