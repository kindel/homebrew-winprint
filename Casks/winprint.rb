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
  version "3.1.3"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v3.1.3/WinPrint-osx-arm64.app.zip"
    sha256 "fd83de7b929b154591b7ce92362f14c191fe0321865713460ab9c3ec46e64a65"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v3.1.3/WinPrint-osx-x64.app.zip"
    sha256 "928bbfac539f39466f9200f582b72e8c133d3498df94f09ccd9d6cdbe3d11fba"
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
