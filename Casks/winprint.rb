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
  version "3.1.6"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v3.1.6/WinPrint-osx-arm64.app.zip"
    sha256 "115195f4e7a3364da50d7051e5c82ba947cd76b4d8b9739b584c38c12cb2b156"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v3.1.6/WinPrint-osx-x64.app.zip"
    sha256 "2eb71a0cb193f0987afec8f5f51fc48c082a8ba8685665a4448a167315debc98"
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
