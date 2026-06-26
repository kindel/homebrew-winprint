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
  version "2.8.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.7/wp-osx-arm64.tar.gz"
      sha256 "8fa968ffc6dcd87ba84043e777736ff9b7870a293de63c638495460ab364b480"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.7/wp-osx-x64.tar.gz"
      sha256 "9db0c259d16e543b329332dc5cbfe697938d6c9dd81ba44011d2d6611151b023"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.8.7/wp-linux-arm64.tar.gz"
      sha256 "f46f813ec995eb8a65dd9c29dcd6aa9823dde5c829a042a1cb58edc0acf133ce"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.8.7/wp-linux-x64.tar.gz"
      sha256 "8a7b2976f38647e59a4fe77924be88cb8cede4ab2d4763d26b2926c31d2a2736"
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
