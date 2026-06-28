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
  version "3.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.3/wp-osx-arm64.tar.gz"
      sha256 "9108f876d25f073a8c079179c2311747688627ed6c9e0c287c08a69522718cfb"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.3/wp-osx-x64.tar.gz"
      sha256 "ae9cece8702d8dcb9384d9009913bbb00036f660bd41f06843cd6dc4db7d6238"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.3/wp-linux-arm64.tar.gz"
      sha256 "8cd10b1bc082951073fa9040087fa766080edc110c85c5e01401771ba335e323"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.3/wp-linux-x64.tar.gz"
      sha256 "f07c75bcf8b47108fad9af39c4fd3a95f51284e21b5975d7cab1faf8b8af0c74"
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
