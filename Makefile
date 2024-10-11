default: apply

apply:
	nix run nix-darwin -- switch --flake .
	# nix run nix-darwin --no-eval-cache -- switch --flake .

upgrade-nix:
	sudo nix upgrade-nix

up: upgrade-nix
	nix flake update

# Sometimes updating breaks things
rollback:
	nix-env --rollback

cleanup:
	#https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
	nix-collect-garbage -d
	nix store gc || true
	nix store optimise

