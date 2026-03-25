Key commands:
- `make` or `make apply`: apply current flake config via nix-darwin switch.
- `make up`: upgrade nix, update flake inputs, re-apply config, run `mise up`.
- `make rollback`: revert to previous nix generation if changes break.
- `make cleanup`: garbage collect nix store and prune Mise installs.
- `uv task run create-molten-env`: set up Molten Neovim venv (per README tip).
- `docker run ... nerdfonts/patcher`: patch fonts inside fonts/in → fonts/out (see README).
- `nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller` and `/nix/nix-installer uninstall`: uninstall stack if needed.