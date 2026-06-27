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
  version "2.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.9.0/wp-osx-arm64.tar.gz"
      sha256 "c93b6fc89592ef9364e20c6afb8776ceca87ffe8eda5747dc525122343a77133"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.9.0/wp-osx-x64.tar.gz"
      sha256 "68e377982e93d689703e8d56fa60e9fa6e06eb6a563f7663ea24ec07f1e59862"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.9.0/wp-linux-arm64.tar.gz"
      sha256 "c55bbbd7de649c8b539f0955b40a463e61935703c77ae31e645f49b6aacb9980"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.9.0/wp-linux-x64.tar.gz"
      sha256 "b8ac9702183b9ed30559d768a9304bf733a0aaa0a37164ce3acd980f0c07fc57"
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
