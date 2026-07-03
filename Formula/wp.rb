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
  version "3.0.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.5/wp-osx-arm64.tar.gz"
      sha256 "dd4840a67d2a9ea15a2be224e60c88f2bcb48c3494b3d7dcaf9ca9aa7ea5d58d"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.5/wp-osx-x64.tar.gz"
      sha256 "86284fd00a4890347356f34c1375000eb338b9710df4a8a14ed14a4b38633ae8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.5/wp-linux-arm64.tar.gz"
      sha256 "6772f8d9b20716d7454464d234e30a9a341e7a04c8f35fd4e10cdef73fcbf8ac"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.5/wp-linux-x64.tar.gz"
      sha256 "590df7f4fa0bb0b1294ee0eb234697d23f7618af3c3921c4dff378e207c5dbcf"
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
