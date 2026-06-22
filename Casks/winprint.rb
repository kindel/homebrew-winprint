# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap. Placeholders are filled with each stable release's version,
# download base URL, and per-arch SHA256s. This is the free MAUI GUI (WinPrint.app), a
# notarized Developer ID build distributed directly (NOT the App Store).
#
# The GUI bundle ALSO embeds the `wp` TUI (release.yml copies the self-contained CLI payload into
# WinPrint.app/Contents/Helpers/wp), so this single cask install delivers BOTH the GUI and the `wp`
# command — the `binary` stanza below symlinks the embedded wp onto PATH. The standalone Homebrew
# *formula* still ships `wp` for Linux and CLI-only installs; the cask therefore conflicts with the
# formula (both would provide `wp`).
cask "winprint" do
  version "2.6.7"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v2.6.7/WinPrint-osx-arm64.app.zip"
    sha256 "621fa6889ca6b4126a3251e3826a90b40b5fbe0ad76273127bac110de20176a6"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v2.6.7/WinPrint-osx-x64.app.zip"
    sha256 "71fd5c07b47e4157dfb7026c4245d18ee1dd6bb5fec34699c95b50c60cb5997f"
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
