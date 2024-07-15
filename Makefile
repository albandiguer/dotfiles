default: apply

apply:
	nix run nix-darwin -- switch --flake .
	# nix run nix-darwin --no-eval-cache -- switch --flake .

upgrade:
	nix flake update

update:
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
