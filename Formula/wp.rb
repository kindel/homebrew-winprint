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
  version "3.0.14"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.14/wp-osx-arm64.tar.gz"
      sha256 "5692547f3fe0d69305e41c81cedd56090ea58284fe4373697c1f5e8be329b126"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.14/wp-osx-x64.tar.gz"
      sha256 "d6b0d026b84c16f9a185810f414aaac3f45b2ac1155e491ff4df5b844fd01f63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.14/wp-linux-arm64.tar.gz"
      sha256 "397e1fd0c056fe2b9d3b401d69303e40997c2121e438b11fa8f3a804fe733519"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.14/wp-linux-x64.tar.gz"
      sha256 "495bbc7758ca1b0dd72f2c2c53b290fdd317f7733b5e42dcff09ad40fa606a37"
    end
  end

  # Homebrew bottle for x86_64 Linux (issue #211). `wp` is a self-contained, prebuilt Native AOT
  # binary, so the "install" is just extracting the tarball above — no compiler is ever invoked.
  # But Homebrew treats a formula with NO bottle as a *source* build and refuses it on any host
  # without a C compiler (fresh containers, minimal WSL). This bottle makes `brew install` POUR a
  # prebuilt tree instead, so a toolchain-less Linux host installs cleanly. :any_skip_relocation is
  # correct because the payload bakes in no Cellar paths.
  #
  # ONLY x86_64_linux is tagged on purpose. Every other platform intentionally has NO tag and keeps
  # installing from the `url` blocks above (macOS has Clang via the Command Line Tools; arm64 Linux
  # source-builds). A declared tag whose bottle file is missing makes Homebrew HARD-FAIL that
  # platform with no source fallback — so never add a tag here without also publishing AND
  # pour-testing its bottle file in the release `brew` job. The block below is rendered + built +
  # uploaded by .github/workflows/release.yml; the sentinel markers let that job strip it to build
  # the bottle from source first. Do not hand-edit the SHA.
  # >>> winprint:bottle (rendered by release.yml — do not hand-edit)
  bottle do
    root_url "https://github.com/tig/winprint/releases/download/v3.0.14"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8012dd121a33aa8649fa9542b62f6c48d502047aa3b3003fcec558454a985cf6"
  end
  # <<< winprint:bottle

  def install
    # Drop the separated debug-symbol file (wp.dbg) before installing. It is useless to end
    # users and — critically — Homebrew's Linux install/pour path scans every ELF in the keg
    # (load_tab -> undeclared_runtime_dependencies -> LinkageChecker), and the vendored
    # elftools gem hangs/crashes parsing this AOT .dbg file ("undefined method 'header' for
    # nil"). That crash is what kept the x86_64_linux bottle from ever pouring (issue #211).
    # Removing it here keeps it out of both the poured bottle and the url/source install path.
    rm_f Dir["*.dbg"]
    libexec.install Dir["*"]
    bin.install_symlink libexec/"wp"
  end

  test do
    system bin/"wp", "--version"
  end
end
