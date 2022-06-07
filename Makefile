default:
	home-manager switch


update:
	nix-channel --update
	home-manager switch

update-nix:
	nix upgrade-nix
