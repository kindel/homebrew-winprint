# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.14/wp-osx-arm64.tar.gz"
      sha256 "737b7ddfe6ac7d9bdd7a972c2513bffff7d63a5064bec15c5e8a1dd5f34bf737"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.14/wp-osx-x64.tar.gz"
      sha256 "09232b5770f0381049f2a87f58b736ba5181c3e7f95645fe589f1bbb02b7331a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.14/wp-linux-arm64.tar.gz"
      sha256 "e20297c8266ee06e44a07ff095c57c439694ed836932f10f2ee2e9c2ad0f8b0b"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.14/wp-linux-x64.tar.gz"
      sha256 "0bfadb976eeae6ff3c6d854848c282e963d5bd4252035df28affad26014c80c5"
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
