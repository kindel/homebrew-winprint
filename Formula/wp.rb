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
  version "3.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.0/wp-osx-arm64.tar.gz"
      sha256 "ad115b49373b3c537561540790fbfc1ef374d5ff939e902a2d3639d7442a6b9d"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.0/wp-osx-x64.tar.gz"
      sha256 "d709d72d39fbe9607ec2b1e4d2ea58ed747380268f1ef27b0ab313df11081a14"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.0/wp-linux-arm64.tar.gz"
      sha256 "ad8cd221fc1412b53be164020f96e8545f2f2aedb862dc805fc1fb1e004e452d"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.0/wp-linux-x64.tar.gz"
      sha256 "94aa7b068ac6aa30256346bdd0a22a35143bfbff63759923632c12a5f9c0aeda"
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
