# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap. Placeholders are filled with each stable release's version,
# download base URL, and per-arch SHA256s. This is the free MAUI GUI (WinPrint.app), a
# notarized Developer ID build distributed directly (NOT the App Store). The TUI (`wp`) ships
# separately as the Homebrew *formula*; `brew upgrade` handles updates for both.
cask "winprint" do
  version "2.6.5"

  on_arm do
    url "https://github.com/tig/winprint/releases/download/v2.6.5/WinPrint-osx-arm64.app.zip"
    sha256 "86fbbfb4c997dd2f89f9aa63b238cc50f8d13ee14449c6f3a3e85e0a31f16f62"
  end
  on_intel do
    url "https://github.com/tig/winprint/releases/download/v2.6.5/WinPrint-osx-x64.app.zip"
    sha256 "237c93a2aab19e7468b068ed7fcab83d4c470a75181644d4fb2c9d3a5772622f"
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
