# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the free TUI (`wp`); the free MAUI
# GUI ships alongside it as the tap's *cask* (packaging/homebrew/Casks/winprint.rb).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.3/wp-osx-arm64.tar.gz"
      sha256 "25fff0655f53985651d5d4b377647e217223dff6592a2b1ad10d7be723942cca"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.3/wp-osx-x64.tar.gz"
      sha256 "f523d4b1a51f771ba986ba30f903485e33683a2112e401c412b66083f1c7915a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.3/wp-linux-arm64.tar.gz"
      sha256 "7c563b35091a60b7661f154269f445354ece17ba0c4903921694f3b5d60e1403"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.3/wp-linux-x64.tar.gz"
      sha256 "771576b0789985a055ce5f0b850131fa995c3c7d80c85efc57b7168c3810e323"
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
