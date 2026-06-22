# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the free TUI (`wp`); the free MAUI
# GUI ships alongside it as the tap's *cask* (packaging/homebrew/Casks/winprint.rb).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.4/wp-osx-arm64.tar.gz"
      sha256 "36c9ce296997bc24134aec1b8e7c8f8135c88511d6e8e81f697e4e5ecbf0c05e"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.4/wp-osx-x64.tar.gz"
      sha256 "a01c95e078ce7c8e062d4e300960848f7aa0786cfbbcd5c33a3a0baaa1f22551"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.4/wp-linux-arm64.tar.gz"
      sha256 "0cdfeb930a80df979147c2ca3f6ac44b9961f6348512bf5db897d7e599f23dea"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.4/wp-linux-x64.tar.gz"
      sha256 "d9017164efbf25ee38c21d393ed96c25e9b90f3dd832f50a35d00c1a71ab5ff9"
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
