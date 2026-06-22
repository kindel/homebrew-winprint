# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap. Placeholders are filled with each stable release's version,
# download base URL, and per-arch SHA256s. This is the free MAUI GUI (WinPrint.app), a
# notarized Developer ID build distributed directly (NOT the App Store). The TUI (`wp`) ships
# separately as the Homebrew *formula*; `brew upgrade` handles updates for both.
cask "winprint" do
  version "2.6.4"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v2.6.4/WinPrint-osx-arm64.app.zip"
    sha256 "f567d944e357882b805da2be8f0bb092d70335ce1db43fcb103be3117c1c7a13"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v2.6.4/WinPrint-osx-x64.app.zip"
    sha256 "30cc5acf1862cf8813b443441f5050b295e3e5540ec4e3bb3a707f88a60bf4f0"
  end

  name "WinPrint"
  desc "Advanced source code and text file printing GUI"
  homepage "https://github.com/kindel/winprint"

  app "WinPrint.app"

  zap trash: [
    "~/Library/Application Support/WinPrint",
    "~/Library/Preferences/com.kindel.winprint.plist",
    "~/Library/Logs/WinPrint",
  ]
end
