# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.8.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.5/wp-osx-arm64.tar.gz"
      sha256 "44c2697536d96960a03022764a72dc52adfffe9d0dddebeccbec3629285802ed"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.5/wp-osx-x64.tar.gz"
      sha256 "fa58ecba48151181a0132c4377c022acb665777a52d7fec4a178dce98e2539a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.5/wp-linux-arm64.tar.gz"
      sha256 "34f0459898774a45837423218c99a53259a788ff847f9df129d7cfcf2e0f9e63"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.5/wp-linux-x64.tar.gz"
      sha256 "4140bdf384bb37fc05b574100b5e5cb04621fa55edb2266b852af35777c0a56f"
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
