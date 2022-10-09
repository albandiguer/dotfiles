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
	#https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
	home-manager expire-generations "-30 days"
	# after expiring generations, run garbage collection
	nix-store --gc || true
	#There is also a convenient little utility nix-collect-garbage, which when invoked with the -d (--delete-old) switch deletes all old generations of all profiles in /nix/var/nix/profiles
	nix-collect-garbage -d
