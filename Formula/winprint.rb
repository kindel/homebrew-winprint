# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.16"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.16/wp-osx-arm64.tar.gz"
      sha256 "4df0794d807f096b19ec0808febebd9d1d637eef89bfb17ba2ad1f5fd437ad29"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.16/wp-osx-x64.tar.gz"
      sha256 "7b80ed9e397266ec0d54dc7a93dd7f60842539bea08c562924ba98d8948a04dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.16/wp-linux-arm64.tar.gz"
      sha256 "2b432705420ffd15b2a8426974c87110c5d0f572ed12b44ca27157f9d1a160d9"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.16/wp-linux-x64.tar.gz"
      sha256 "842dfea1b4a7e1bd59495c6f5fe8658e76b2e26409e5f2d42f293194b4a5e38f"
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
