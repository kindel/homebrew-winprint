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
  version "2.9.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.9.2/wp-osx-arm64.tar.gz"
      sha256 "0a03ff9c2c7d8a296c396442b6c7c7515da66871cd343d2eac30085d17e19714"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.9.2/wp-osx-x64.tar.gz"
      sha256 "05456ad965899fe5312440deb049ee3ff283a67798f19a3a61114573f1fabb14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.9.2/wp-linux-arm64.tar.gz"
      sha256 "9fa2a0d7340da73587b7cd993ef02f612505ded37fa2a344e4d1427f2d96a0e0"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.9.2/wp-linux-x64.tar.gz"
      sha256 "6148367b125de3dc4d16c8ff2f9951fdff7ddc3c348610a80bf5e9a7417bf260"
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
