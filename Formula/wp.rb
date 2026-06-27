# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s.
#
# This formula is the standalone free TUI (`wp`) — used on Linux and for CLI-only macOS installs.
# The full macOS app ships as the tap's *cask* `winprint` (packaging/homebrew/Casks/winprint.rb),
# which embeds `wp` already, so `brew install winprint` on a Mac delivers GUI + CLI from one
# command. The formula is named `wp` (not `winprint`) on purpose: if a formula and a cask shared
# the name `winprint`, `brew install winprint` would silently pick the formula and skip the GUI.
# Both provide the `wp` symlink, so installing this formula AND the cask collides — pick one on macOS.
class Wp < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/tig/winprint"
  version "2.8.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.9/wp-osx-arm64.tar.gz"
      sha256 "8ac3be44dce4042acd1de4ee900b24047e32b6e709ccaf5eb67c00e502241dfe"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.9/wp-osx-x64.tar.gz"
      sha256 "02b8c4da9bc2abd3eb030857a4b2ddce9d0c0bf054f0cab42b56b89d208f212c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.9/wp-linux-arm64.tar.gz"
      sha256 "7bbef9d16d2b6df6fa0bbb8e0f5802d55f5a0c2cb66b1ae3b6a4a45deb32a86f"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.9/wp-linux-x64.tar.gz"
      sha256 "d5d5c0633310aa07cd3de97c53503e8c0ed6ad00b5b0f0b81dafeb8df402f1d4"
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
