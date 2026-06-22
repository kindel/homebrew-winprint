# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.7/wp-osx-arm64.tar.gz"
      sha256 "91d0f0675088371c6b8e8fe9fa4f9e029c26bc31ad1c5dc7f708eb99e6bdf7d7"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.7/wp-osx-x64.tar.gz"
      sha256 "08076ce2d54767d6a44ace3d1d2e99eadbefed2ca7b8459c8d05fb3b9c355e81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.7/wp-linux-arm64.tar.gz"
      sha256 "ee9910de8333a4d88717665f80206fdf8e7bfb314663b145ce75db48a840a3fd"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.7/wp-linux-x64.tar.gz"
      sha256 "5b045d6fb68feb08dee51eb459531b7915d03c73a22659bbfc5e982957b3b19f"
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
