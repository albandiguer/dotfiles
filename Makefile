all: dev brew brew-deps dns apache-conf zsh links vim-plugins

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
	brew install cmake || true # for compiling YCM || true
	brew install ctags || true
	brew install git || true
	brew install nodenv || true
	brew install rbenv || true
	brew install ruby-build || true
	brew install the_silver_searcher || true
	brew install tmux || true
	brew install vim || true
	brew install watch || true
	brew install wget || true
	brew install reattach-to-user-namespace || true
	brew install selecta || true
	# brew install tern || true
	brew unlink ruby # vim installs its own ruby dep, we unlink to avoid conflicts with rbenv
	brew unlink node
	brew install grip || true # preview MD files

linters:
	yarn global add eslint babel-eslint eslint-plugin-react -g

install-vundle:
	mkdir ~/.vim/bundle || true
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall

command-t:
	cd ~/.vim/bundle/command-t/ruby/commant-t && ruby extconf.rb && make

ycm:
	cd ~/.vim/bundle/YouCompleteMe && chmod +x install.py && ./install.py --clang-completer --tern-completer

tern:
	cd ~/.vim/bundle/tern_for_vim && yarn install

dns:
	brew install dnsmasq || true
	rm /usr/local/etc/dnsmasq.conf
	ln -s `pwd`/dnsmasq.conf /usr/local/etc/ || true
	sudo ln -s `pwd`/resolver /etc || true
	sudo brew services restart dnsmasq # sudo because it needs to be in /Library/LaunchDaemons, see $brew services

tbb-mysql55:
	brew install mysql@5.5 || true
	mysql -uroot --execute="create user 'tbb'@'localhost' identified by 'password';"
	mysql -uroot --execute="grant all on *.* TO 'tbb'@'localhost';"
	mysql -uroot --execute="create database bb_dev"

apache-conf:
	# Inside /private/etc/apache2/httpd.conf
	# Uncomment Include /private/etc/apache2/extra/httpd-vhosts.conf
	# mod_proxy and mod_proxy_http
	# Uncomment LoadModule vhost_alias_module libexec/apache2/mod_vhost_alias.so
	sudo rm /private/etc/apache2/extra/httpd-vhosts.conf || true
	sudo ln -sf `pwd`/httpd-vhosts.conf /private/etc/apache2/extra/ || true
	sudo apachectl restart

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
	ln -sf `pwd`/.eslintrc ~/.eslintrc || true
	ln -sf `pwd`/.rspec ~/.rspec || true
	ln -sf `pwd`/.babelrc ~/.babelrc || true
	ln -sf `pwd`/.inputrc ~/.inputrc || true
	ln -sf `pwd`/.tern-config  ~/.tern-config || true
	ln -sf `pwd`/.rubocop.yml  ~/.rubocop.yml || true

visual-studio-conf:
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
	defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false

ruby-autocomplete:
	gem install rcodetools fastri ruby-debug-ide

