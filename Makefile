default:
	home-manager switch


update:
	nix-channel --update
	home-manager switch

update-nix:
	echo 'disable zsh enable completion beforehand'
	echo 'https://github.com/NixOS/nix/issues/5445'
	nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert
