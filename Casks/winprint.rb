# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap. Placeholders are filled with each stable release's version,
# download base URL, and per-arch SHA256s. This is the free MAUI GUI (WinPrint.app), a
# notarized Developer ID build distributed directly (NOT the App Store). The TUI (`wp`) ships
# separately as the Homebrew *formula*; `brew upgrade` handles updates for both.
cask "winprint" do
  version "2.6.3"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v2.6.3/WinPrint-osx-arm64.app.zip"
    sha256 "7d12b9ec483efc981ba5508bd276d399ea278f25b2767d789af96065dc15350e"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v2.6.3/WinPrint-osx-x64.app.zip"
    sha256 "3cfce7abdfafdcf2e6d8971a8308bd833de9d05118905fc576feadf21ed9cf14"
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
