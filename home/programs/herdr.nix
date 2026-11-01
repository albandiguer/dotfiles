{ config, lib, pkgs, herdr-worktreeinclude, herdr-workspace-manager, ... }:

let
  # Upstream ships a shim that runs `cargo build` on first use. Build it here so
  # the plugin starts instantly and the store stays read-only.
  workspaceManager = pkgs.rustPlatform.buildRustPackage {
    pname = "herdr-workspace-manager";
    version = "0.8.0";
    src = herdr-workspace-manager;
    cargoLock.lockFile = "${herdr-workspace-manager}/Cargo.lock";
    doCheck = false;
  };

  # Upstream copies matches with `cp -p`, which follows symlinks and silently
  # skips a symlink to a directory. In a repo whose `.beads` links to the parent
  # checkout's database, the new worktree would end up with no `.beads` at all;
  # recreate the link (target resolved) instead of copying it.
  worktreeIncludePlugin = pkgs.runCommand "herdr-worktreeinclude-plugin" { } ''
    cp -r ${herdr-worktreeinclude}/. $out
    chmod -R u+w $out
    substituteInPlace $out/copy-worktreeinclude.sh --replace-fail \
      'cp -p "$abs" "$checkout/$f"' \
      'if [ -L "$abs" ]; then ln -sfn "$(readlink -f "$abs")" "$checkout/$f"; else cp -p "$abs" "$checkout/$f"; fi'
  '';

  workspaceManagerPlugin = pkgs.runCommand "herdr-workspace-manager-plugin" { } ''
    mkdir -p $out
    cat > $out/herdr-plugin.toml <<EOF
    id = "herdr-plugin-workspace-manager"
    name = "Workspace Manager"
    version = "0.8.0"
    min_herdr_version = "0.7.5"
    description = "Declarative tab/pane layouts applied to new worktrees."
    platforms = ["macos"]

    [[startup]]
    command = ["${workspaceManager}/bin/herdr-workspace-manager", "startup"]

    [[events]]
    on = "worktree.created"
    command = ["${workspaceManager}/bin/herdr-workspace-manager", "event"]

    [[events]]
    on = "workspace.created"
    command = ["${workspaceManager}/bin/herdr-workspace-manager", "event"]

    [[events]]
    on = "workspace.focused"
    command = ["${workspaceManager}/bin/herdr-workspace-manager", "event"]
    EOF
  '';
in
{
  programs.herdr = {
    enable = true;
    # package is the default herdr from nixpkgs
    settings.onboarding = false;
  };

  xdg.configFile."herdr/plugins/config/herdr-plugin-workspace-manager/config.yml".source =
    ./herdr/plugins/workspace-manager/config.yml;

  home.activation.linkHerdrPlugins =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${lib.getExe pkgs.herdr} plugin link ${worktreeIncludePlugin}
      $DRY_RUN_CMD ${lib.getExe pkgs.herdr} plugin link ${workspaceManagerPlugin}
    '';
}
