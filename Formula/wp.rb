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
  version "3.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.2/wp-osx-arm64.tar.gz"
      sha256 "bc5b9d6a113e4998169332ba374605c33130a607a693a03f48210436445d8281"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.2/wp-osx-x64.tar.gz"
      sha256 "64013172d5c238f2c9a74bc3c18f3998e870b1e845d8b424a5e4bb870c8d2714"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.2/wp-linux-arm64.tar.gz"
      sha256 "5393dc3271ec0d338bd5029997a48916307d75cdb18e8db3fd25f335e43062dc"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.2/wp-linux-x64.tar.gz"
      sha256 "064a0d943b90275d6ca56799559482040b89a37e27e0f860f6b42d960acb5bb4"
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
