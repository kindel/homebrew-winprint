# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.17/wp-osx-arm64.tar.gz"
      sha256 "94ff907a977c7f76ac80538118d3678ee474eb0ee708ed0fe024b570e286b37c"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.17/wp-osx-x64.tar.gz"
      sha256 "1b829ffab64664333867617bde98e38cf196df58f3d46bec0808ad57620b9301"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.17/wp-linux-arm64.tar.gz"
      sha256 "d9ec64676d4e58a300f3a5dd1bc6409f6e53401da41124323acd8244d71307f4"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.17/wp-linux-x64.tar.gz"
      sha256 "ed826af084338bcfdba1fe100060e9a000c02c006182e36a22804fb34f30f4fc"
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
