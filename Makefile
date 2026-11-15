# sudo resets the environment, so NIX_REMOTE=daemon must be on the command line.
# As root, nix bypasses the daemon and opens the local store directly, where it
# blocks on a DB lock the running nix-daemon holds shared (schema migrations).
SUDO := sudo NIX_REMOTE=daemon

DAEMON_PLIST := /Library/LaunchDaemons/org.nixos.nix-daemon.plist

.PHONY: default apply up upgrade-nix rollback cleanup skills-installs prune-daemons

default: apply

# nix-daemon forks a child per client connection; `launchctl bootout` leaves those
# children behind (reparented to 1), each holding a shared store lock for life. Then
# anything needing the exclusive lock hangs forever: a DB migration, an optimise, a
# root client. So drop any daemon that is not from the currently loaded plist.
prune-daemons:
	@want=$$(grep -o '/nix/store/[a-z0-9]*-nix-[0-9.]*' $(DAEMON_PLIST) | head -1); \
	[ -n "$$want" ] || { echo "no nix-daemon plist, skipping"; exit 0; }; \
	for pid in $$(ps -eo pid=,command= | grep '[b]in/nix-daemon' | grep -v "$$want" | awk '{print $$1}'); do \
		echo "killing stale nix-daemon $$pid"; sudo kill -9 $$pid; \
	done

apply: prune-daemons
	$(SUDO) nix run nix-darwin -- switch --flake .
	# $(SUDO) nix run nix-darwin --no-eval-cache -- switch --flake .
	brew bundle --file=homebrew/Brewfile
	@h=$$(scutil --get LocalHostName); if [ -f homebrew/Brewfile.$$h ]; then brew bundle --file=homebrew/Brewfile.$$h; fi

upgrade-nix: prune-daemons
	$(SUDO) nix upgrade-nix

up:
	nix flake update
	$(MAKE) apply
	mise up
	# Check for skill updates
	npx skills check -g
	npm update -g
	pi update
	pi update --extensions
	# TODO:
	# nvim +Lazy\ update
	# nvim +MasonToolsUpdate

skills-installs:
	# Restore global skills from lock file
	fish -c skills-install

# Sometimes updating breaks things
rollback: prune-daemons
	$(SUDO) nix run nix-darwin -- rollback --flake .

cleanup: prune-daemons
	# https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
	$(SUDO) nix-collect-garbage -d
	nix store gc
	nix store optimise
	mise prune -y
