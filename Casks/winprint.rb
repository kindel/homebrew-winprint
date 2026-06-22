# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap. Placeholders are filled with each stable release's version,
# download base URL, and per-arch SHA256s. This is the free MAUI GUI (WinPrint.app), a
# notarized Developer ID build distributed directly (NOT the App Store).
#
# The GUI bundle ALSO embeds the `wp` TUI (release.yml copies the self-contained CLI payload into
# WinPrint.app/Contents/Helpers/wp), so this single cask install delivers BOTH the GUI and the `wp`
# command — the `binary` stanza below symlinks the embedded wp onto PATH. The standalone Homebrew
# *formula* still ships `wp` for Linux and CLI-only installs. Both provide `wp`, so installing the
# cask and the formula together collides on the `wp` symlink (Homebrew errors at link time) — pick
# one on macOS. (Casks can't declare a `conflicts_with formula:`; that key is cask-only, so we just
# document it here instead of encoding an invalid stanza.)
cask "winprint" do
  version "2.6.8"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v2.6.8/WinPrint-osx-arm64.app.zip"
    sha256 "db8eb52a7003dd1116b0843e2c8b7e8a0f9a513134e8f1ac75818e48d5f56a2c"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v2.6.8/WinPrint-osx-x64.app.zip"
    sha256 "4b2df3aac1adf75c8095c371a8226ffab49ef620f206dce94e9e8780c3551a39"
  end

  name "WinPrint"
  desc "Advanced source code and text file printing GUI (bundles the wp TUI)"
  homepage "https://github.com/kindel/winprint"

  app "WinPrint.app"
  binary "#{appdir}/WinPrint.app/Contents/Helpers/wp/wp"

  zap trash: [
    "~/Library/Application Support/WinPrint",
    "~/Library/Preferences/com.kindel.winprint.plist",
    "~/Library/Logs/WinPrint",
  ]
end
