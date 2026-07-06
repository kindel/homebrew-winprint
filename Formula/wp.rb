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
  version "3.0.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.12/wp-osx-arm64.tar.gz"
      sha256 "64a87184ed931fac6bc01d5bc20b0d5a357a34ae4891e70aabb81ba485006b1a"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.12/wp-osx-x64.tar.gz"
      sha256 "9b4d053fcdab2185fb385018eb91e4513a61215a81516996018b7384826ef692"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.0.12/wp-linux-arm64.tar.gz"
      sha256 "d9d5788c1c3c597c0de517f596948ba23c73f35cd64994b0ad36385bdff4475e"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.0.12/wp-linux-x64.tar.gz"
      sha256 "a9da123101fb98dcd61ecdf993af0d49a402b3eb6db824bfc6b1e6aa23d8d1fa"
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
    root_url "https://github.com/tig/winprint/releases/download/v3.0.12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b60ee9ceb98060f871584447d45f77e8c2e114fca0e8dd203b204645a1d6144"
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
