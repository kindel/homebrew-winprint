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
  version "3.1.1"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v3.1.1/WinPrint-osx-arm64.app.zip"
    sha256 "3907a3ea2bec21f5d598b428564e0dae9eca58989cf5981204e99fbb1b7a3565"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v3.1.1/WinPrint-osx-x64.app.zip"
    sha256 "256c8d18865fa76a1c352b60654a9b617e8c60451416caabf86fbb607516a71b"
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
