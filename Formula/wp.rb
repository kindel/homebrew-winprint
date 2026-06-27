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
  homepage "https://github.com/kindel/winprint"
  version "2.8.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.8/wp-osx-arm64.tar.gz"
      sha256 "a357af8441b722623cb8255ca057efab89fbdcb6a2ee7fad99f21683827ad35e"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.8/wp-osx-x64.tar.gz"
      sha256 "cdf3a22ade464c89882282dffbd1595001c7b4e5e41b799eb1d2adce7e99ca51"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.8/wp-linux-arm64.tar.gz"
      sha256 "74990c964e916a20fcc38a7d601216dd1a7225735493d7939769df67163950c1"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.8/wp-linux-x64.tar.gz"
      sha256 "0c291c7453e9254d11dff0016e613b2f81910d381cee07b5c951e162bba38c20"
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
