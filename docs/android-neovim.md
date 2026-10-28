# Android in Neovim (android-nvim-plugin + per-project mise)

Android work happens in [android-nvim-plugin](https://github.com/iamironz/android-nvim-plugin):
build, run, logcat, AVD/device management, Gradle task browser. No Android Studio.

The Android toolchain is **not global**: no `android-sdk`/`java` in the global mise config
(`home/programs/mise.nix`). Each Android project declares it in its own `mise.toml`, so `adb`,
`ANDROID_HOME` and `JAVA_HOME` only exist inside those projects.

## What is declared where

| Piece | Source | Notes |
| --- | --- | --- |
| `cmdline-tools` (`sdkmanager`, `avdmanager`) | project `mise.toml` → `android-sdk = "23.0"` | vfox plugin; version = cmdline-tools version |
| JDK 21 | project `mise.toml` → `java = "temurin-21"` | also runs `sdkmanager` |
| `ANDROID_HOME`, `ANDROID_SDK_ROOT`, `JAVA_HOME` | set by mise, project-scoped | no Home Manager `sessionVariables` |
| `adb`, `emulator`, `build-tools` on `PATH` | mise plugin, once installed into the SDK | appended only if the dirs exist |
| SDK *packages* (platforms, build-tools, images) | imperative `sdkmanager` | Google's channel, not pinned by Nix |
| Neovim plugin | `home/programs/neovim/nvim/lua/custom/plugins/android.lua` | `require('android').setup()` |

Deliberately **not** in Nix: `androidenv` gives a read-only store, so `sdkmanager` can't install into
it. Not in Homebrew either — mise owns the toolchain, one source of truth.

## Project setup

Add to the project's `mise.toml` (or `mise use android-sdk@23.0 java@temurin-21`):

```toml
[tools]
android-sdk = "23.0"     # pin it: SDK packages live inside the install dir of this version
java = "temurin-21"
```

```bash
mise trust          # first time in that project
mise install        # cmdline-tools + JDK, into mise's shared store
```

Pin the cmdline-tools version — with `latest`, a `mise upgrade` switches to a new install dir and
every `sdkmanager` package has to be reinstalled.

Then install the SDK packages once, matching the project's `compileSdk` (example: 36). Installs are
shared by every project that declares the same `android-sdk` version:

```bash
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0" "emulator"
sdkmanager "system-images;android-36;google_apis;arm64-v8a"   # only for emulators
avdmanager list device                                        # pick an id, then:
avdmanager create avd -n pixel36 -k "system-images;android-36;google_apis;arm64-v8a" -d <device-id>
```

Sanity check from the project root: `adb version`, `java -version`, `sdkmanager --version`. With
cmdline-tools 23 the `--licenses` step is gone, and `android sdk` is the upstream replacement for
`sdkmanager`. `adb devices` must list a phone or a running AVD before build-and-run works.

## Per project conventions

- `./gradlew` from the repo is used as-is — nothing to configure for Gradle.
- SDK discovery order: plugin config → `local.properties` (`sdk.dir`) → `ANDROID_HOME` →
  OS defaults. mise sets `ANDROID_HOME` inside the project, so `local.properties` is optional.
- Optional `.android.nvim.json` in the project root for shell run configs (see
  [run configs](https://github.com/iamironz/android-nvim-plugin/blob/main/docs/guides/run-configs.md)).
- Start Neovim from the project root (or any subdir) so mise has the env active.

## Daily use

| Action | Command |
| --- | --- |
| Hub menu | `:AndroidMenu` / `<leader>am` |
| Pick device | `:AndroidTargets` / `<leader>at` |
| Tools (Gradle tasks, AVDs, adb actions) | `:AndroidTools` / `<leader>ao` |
| Build → install → launch → logcat | `:AndroidBuild` / `<leader>ab` |
| Assemble only | `:AndroidBuildAssemble` |
| Logcat dock | `:AndroidLogcat` |
| Run / stop run config | `:AndroidRun`, `:AndroidRunStop` |
| Health check | `:checkhealth android` |

Selections (module, variant, device, AVD, logcat state) are remembered per workspace.

## Failure modes

- **`adb: command not found` / `:checkhealth android` finds no SDK** — expected outside a project:
  the tool is project-scoped. Check `:lua =vim.env.ANDROID_HOME` from inside the project, and that
  `mise trust` was run.
- **Two `adb`s / daemon version mismatch** — some other install owns `adb` (nix `android-tools`,
  Homebrew `android-platform-tools`). Keep only the SDK's; check with `which -a adb`.
- **Gradle picks the wrong JDK** — `JAVA_HOME` should be mise's temurin-21; the project's
  `jvmToolchain` wins over it, so check `./gradlew -version`.
- **Emulator won't start on Apple Silicon** — needs an `arm64-v8a` system image, not `x86_64`.
- **Packages vanished after an upgrade** — cmdline-tools version changed (install dir changed);
  pin `android-sdk` and rerun the `sdkmanager` line.

## Policy

Nix manages the editor; mise manages the Android toolchain because `sdkmanager` needs a writable
root and SDK levels are per project. New machine: `make apply` → per-project `mise install` →
`sdkmanager` line (SDK packages are never reproduced automatically).
