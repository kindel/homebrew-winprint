# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap. Placeholders are filled with each stable release's version,
# download base URL, and per-arch SHA256s. This is the free MAUI GUI (WinPrint.app),
# distributed directly (NOT the App Store). The app is signed with an Apple Developer ID and
# notarized + stapled by the release pipeline (the APPLE_* secrets are configured), so Gatekeeper
# accepts it without a quarantine workaround.
#
# The GUI bundle ALSO embeds the `wp` TUI (release.yml copies the self-contained CLI payload into
# WinPrint.app/Contents/Helpers/wp), so this single cask install delivers BOTH the GUI and the `wp`
# command — the `binary` stanza below symlinks the embedded wp onto PATH. `brew install winprint`
# therefore installs everything a Mac user needs. The CLI-only `wp` *formula* still ships for Linux
# and headless macOS; it also provides `wp`, so installing the cask AND the formula collides on the
# `wp` symlink (Homebrew errors at link time) — pick one on macOS. (Casks can't declare a
# `conflicts_with formula:`; that key is cask-only, so we just document it here.)
cask "winprint" do
  version "3.0.11"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v3.0.11/WinPrint-osx-arm64.app.zip"
    sha256 "7e3a67c31f961fc0ea83c001f7950c35ef76cdaf520bb46fa895a03126551b1d"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v3.0.11/WinPrint-osx-x64.app.zip"
    sha256 "4bc7c1ee8d5b23ce1fef051eafc49dd72c242b7c825540bd1a9e6ce75c56f1bc"
  end

  name "WinPrint"
  desc "Advanced source code and text file printing GUI (bundles the wp TUI)"
  homepage "https://github.com/tig/winprint"

  app "WinPrint.app"
  binary "#{appdir}/WinPrint.app/Contents/Helpers/wp/wp"

  zap trash: [
    "~/Library/Application Support/WinPrint",
    "~/Library/Preferences/com.kindel.winprint.plist",
    "~/Library/Logs/WinPrint",
  ]
end
