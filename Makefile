default:
	home-manager switch

update:
	nix-channel --update
	home-manager switch

upgrade-nix:
	nix upgrade-nix


cleanup:
	# remove old generations
