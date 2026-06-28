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
  version "3.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.1/wp-osx-arm64.tar.gz"
      sha256 "5ced5a66f232620e2d14395e307a816c80413e6bc041f325c8fea7c68c8efe53"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.1/wp-osx-x64.tar.gz"
      sha256 "97e367f37db91b00c64ed297386fdb87909445945f653f287ba716c636f04358"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.1/wp-linux-arm64.tar.gz"
      sha256 "78b7fe55450f44b7442ff8b29cc8ac78098e954a75829dbe250babefdb74154b"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.1/wp-linux-x64.tar.gz"
      sha256 "c22039dace873d5c402607a57c7cbf77fb63f94c8d7fd205581ce38356948e20"
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
