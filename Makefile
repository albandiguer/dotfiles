default: update

update:
	nix flake update
	nix run nix-darwin  -- switch --flake .

upgrade-nix:
	sudo nix upgrade-nix

# Sometimes updating breaks things
rollback:
	# TODO

tiling-stop:
	pgrep yabai | xargs kill -9
	pgrep skhd | xargs kill -9

tiling: tiling-stop
	yabai &
	skhd &

cleanup:
	#https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
	nix store gc || true
	nix store optimise
	#There is also a convenient little utility nix-collect-garbage, which when invoked with the -d (--delete-old) switch deletes all old generations of all profiles in /nix/var/nix/profiles
	nix-collect-garbage -d
