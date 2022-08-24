default:
	home-manager switch --max-jobs auto --cores 8

update:
	nix-channel --update
	home-manager switch --max-jobs auto --cores 8

upgrade-nix:
	nix upgrade-nix


# Sometimes updating breaks things
rollback:
	nix-channel --rollback

cleanup:
	# remove old generations
