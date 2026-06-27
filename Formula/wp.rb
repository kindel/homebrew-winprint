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
  version "2.8.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.10/wp-osx-arm64.tar.gz"
      sha256 "a682811b79b2b9c4a1a5f250b7577fe8d3110d53b5abd10bd42ab8c6c53685ee"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.10/wp-osx-x64.tar.gz"
      sha256 "d27145cfd4761cc22d33c5636b8659dda3b2f4d0c2cfb758732b482f4e0809a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.10/wp-linux-arm64.tar.gz"
      sha256 "00e256c821818dbac5c5a94dcd8b57f21845358376cbe2d839dc565d4a812c4c"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.10/wp-linux-x64.tar.gz"
      sha256 "1a83af0c47318a6956c2e5b946461de96853255be038d6532ab7b8df912959f4"
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
