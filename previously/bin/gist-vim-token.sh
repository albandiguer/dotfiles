#!/bin/bash

# Add a gist token to ~/.gist-vim
add-gist-vim() {
	echo "token $(gh auth token)" | tee ~/.gist-vim
}
