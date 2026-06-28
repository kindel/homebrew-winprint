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
  version "2.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.9.1/wp-osx-arm64.tar.gz"
      sha256 "01a500bd493e5187d735ec34c7497e843dd7576e6be5304437a87ec7ae4ec449"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.9.1/wp-osx-x64.tar.gz"
      sha256 "4ae88ee406c6e5104135b796ca6cbfd27001eb16b962ab5248a1f77fa5d49434"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.9.1/wp-linux-arm64.tar.gz"
      sha256 "104928be17de0af6c951b320d96b11c9181fd40ba1ff1e79b8e12873b0442010"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.9.1/wp-linux-x64.tar.gz"
      sha256 "a889bb24db59eba16a68d999853b96f06efbab47499cc113ffd0dccdb100849e"
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
