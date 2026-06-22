# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.11/wp-osx-arm64.tar.gz"
      sha256 "44f797254544106ebe5adca27dc357220828a8c02f06020946f7ef0012e7b8fd"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.11/wp-osx-x64.tar.gz"
      sha256 "7f0d2a7b90a7c50ecec12f940c1bb452936512eda5db67f36b1991160e4f86f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.11/wp-linux-arm64.tar.gz"
      sha256 "71a8e01c7e3d7b99dc867a8e40d246dc2ef9d980ec39d262c2b0b1beecc63eb3"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.11/wp-linux-x64.tar.gz"
      sha256 "f1b70b9048d613c00b48b4709e9c241310ea138f0f3e3d33400744788ed6abd3"
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
