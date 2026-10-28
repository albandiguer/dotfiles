-- android-nvim-plugin — build/run/logcat/AVD/adb/Gradle tasks for Android & KMP.
-- https://github.com/iamironz/android-nvim-plugin
-- Default maps: <leader>am menu, at targets, ao tools, aa actions, ab build.
-- SDK/adb/JDK are declared per project in its mise.toml, not globally (docs/android-neovim.md).
-- `:checkhealth android` to verify.
return {
  'iamironz/android-nvim-plugin',
  lazy = false,
  config = function()
    require('android').setup()
  end,
}
