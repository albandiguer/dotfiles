default:
	home-manager switch

update:
	nix-channel --update
	home-manager switch

upgrade-nix:
	nix upgrade-nix


# Sometimes updating breaks things
rollback:
	nix-channel --rollback

cleanup:
	# remove old generations
