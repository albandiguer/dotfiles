set -g fish_eof none
set -gx LANG en_AU.UTF-8
set -gx PATH /Users/albandiguer/.local/share/mise/shims $PATH
set -gx PATH /Users/albandiguer/.npm-packages/bin $PATH
set -gx PATH /opt/homebrew/opt/icu4c/bin $PATH
set -gx BAT_THEME "1337"

# Build deps required for mise to install postgres (and similar tools)
set -gx PKG_CONFIG_PATH /opt/homebrew/opt/icu4c/lib/pkgconfig /opt/homebrew/opt/curl/lib/pkgconfig /opt/homebrew/opt/zlib/lib/pkgconfig $PKG_CONFIG_PATH
set -gx MACOSX_DEPLOYMENT_TARGET (sw_vers -productVersion)

# Set DOCKER_HOST from podman machine if available
if command -v podman > /dev/null
	and podman machine list --format json | jq -e '.[].Running' > /dev/null 2>&1
	set -gx DOCKER_HOST (podman machine inspect | jq -r '.[0].ConnectionInfo.PodmanSocket.Path | sub("^"; "unix://")')
end

# git-spice (gs) shell completion
function __complete_gs
	set -lx COMP_LINE (commandline -cp)
	test -z (commandline -ct)
	and set COMP_LINE "$COMP_LINE "
	/etc/profiles/per-user/albandiguer/bin/gs
end
complete -f -c gs -a "(__complete_gs)"
