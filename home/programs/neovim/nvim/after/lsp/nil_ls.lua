-- nil_ls: Nix LSP configuration
-- autoArchive: automatically archive flakes without prompting

return {
  settings = {
    ['nil'] = {
      nix = {
        flake = {
          autoArchive = true,
        },
      },
    },
  },
}
