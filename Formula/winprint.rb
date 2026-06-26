# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.8.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.6/wp-osx-arm64.tar.gz"
      sha256 "8f86d3cceaff7f724cf35d332450dc09abbd126f0d1a9a72d63f302f700d89d7"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.6/wp-osx-x64.tar.gz"
      sha256 "af4166dab34998558d8408238a33dbc380eb1573c387f8d82e5fa8cf63a4bb51"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.6/wp-linux-arm64.tar.gz"
      sha256 "1ffa2b9a9a859c71726f1a118bf8f5d68b6740c6d086c2c752a820961bc4184a"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.6/wp-linux-x64.tar.gz"
      sha256 "23749a13152d026d13fe2b0f8f39494c9a3d2a560f7c3a1053f58eb500cc5e5a"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"wp"
  end

  test do
    system bin/"wp", "--version"
  end
end
