default: apply

apply:
	sudo nix run nix-darwin -- switch --flake .
	# nix run nix-darwin --no-eval-cache -- switch --flake .
	# Restore skills from lock file
	npx skills experimental_install || true

upgrade-nix:
	sudo nix upgrade-nix

up: upgrade-nix
	nix flake update
	make apply
	mise up
	# Check for skill updates
	npx skills check
	# TODO:
	# nvim +Lazy\ update
	# nvim +MasonToolsUpdate



# Sometimes updating breaks things
rollback:
	nix-env --rollback

cleanup:
	#https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
	sudo nix-collect-garbage --delete-older-than 30d || true
	sudo nix-collect-garbage -d
	nix store gc || true
	nix store optimise
	mise prune -y

