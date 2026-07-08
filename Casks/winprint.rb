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
  version "3.1.0"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v3.1.0/WinPrint-osx-arm64.app.zip"
    sha256 "1c2b70df6080d5dd87aa97fde66a3778a1f4ecf74cbb9213c584fc6ae27df913"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v3.1.0/WinPrint-osx-x64.app.zip"
    sha256 "11950d8598d7ee3a49f26c1f155dff2a1db46294d3491af32bfb25bb57d6ed9a"
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
