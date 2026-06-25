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
  version "2.7.0"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v2.7.0/WinPrint-osx-arm64.app.zip"
    sha256 "87b5fc1cb5a98e973d0c2c296aea55ebb9cc8a2c5262b7f8818c45dcb96b5ec8"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v2.7.0/WinPrint-osx-x64.app.zip"
    sha256 "ce709d21f1a8ec84ac244caed7229f6f3723a4fdf50615758e7c1e572a9056b9"
  end

  name "WinPrint"
  desc "Advanced source code and text file printing GUI (bundles the wp TUI)"
  homepage "https://github.com/kindel/winprint"

  app "WinPrint.app"
  binary "#{appdir}/WinPrint.app/Contents/Helpers/wp/wp"

  # WinPrint.app is not yet Apple-notarized (tracked in tig/winprint#162), so Gatekeeper may
  # report it as "damaged". Remove this caveat once notarization ships.
  caveats <<~EOS
    WinPrint.app is not yet notarized by Apple. If macOS says it "is damaged and can't be
    opened", clear the download quarantine and reopen it:
      xattr -dr com.apple.quarantine "#{appdir}/WinPrint.app"
  EOS

  zap trash: [
    "~/Library/Application Support/WinPrint",
    "~/Library/Preferences/com.kindel.winprint.plist",
    "~/Library/Logs/WinPrint",
  ]
end
