# Folder Structure Issues

Findings from a review of the repo layout. The skeleton (darwin/ + home/programs/ + homebrew/ + specifics/) is the standard nix-darwin flake pattern and is fine. Only open items are listed.

## Fix

| #   | Issue                                                                                | Fix      |
| --- | ------------------------------------------------------------------------------------ | -------- |
| 3   | `home/programs/sops/` — zero references anywhere, not imported                        | Delete   |
