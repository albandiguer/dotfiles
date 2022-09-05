default:
	home-manager switch --max-jobs auto --cores 8

update:
	nix-channel --update
	home-manager switch --max-jobs auto --cores 8

upgrade-nix:
	sudo nix upgrade-nix

# Sometimes updating breaks things
rollback:
	nix-channel --rollback

tiling-stop:
	pgrep yabai | xargs kill -9
	pgrep skhd | xargs kill -9

tiling: tiling-stop
	yabai &
	skhd &

cleanup:
	#https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
	home-manager expire-generations "-10 days"
	# after expiring generations, run garbage collection
	nix-store --gc || true
	#There is also a convenient little utility nix-collect-garbage, which when invoked with the -d (--delete-old) switch deletes all old generations of all profiles in /nix/var/nix/profiles
	nix-collect-garbage -d
