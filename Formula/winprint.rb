# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.9/wp-osx-arm64.tar.gz"
      sha256 "e638e463189deebfeb39a9f994035533a12e0f48ccbcb403f444f0b3e97a9a7a"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.9/wp-osx-x64.tar.gz"
      sha256 "74a34d5889a6c26f5b710cab237ca02646b011724e7d2e0abb28e12dc6b286f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.9/wp-linux-arm64.tar.gz"
      sha256 "944c28bf2f29bf543501324920111acb2478d77f06d5f3e6cb5ee711d562c4d9"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.9/wp-linux-x64.tar.gz"
      sha256 "48e06db1cd9e4a1539dd82a1cc93bec96c48a5aa4f630c5fdd83bfb8708b4f00"
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
