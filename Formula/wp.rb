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
  version "3.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.1.2/wp-osx-arm64.tar.gz"
      sha256 "4d14b17a14d9f978d0f002bae42af76a390b2966d2a00103d09c6b3f898eed81"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.1.2/wp-osx-x64.tar.gz"
      sha256 "94e295f32eae7b507c26b1bf2f7d2323f91917a0d706924bd321c45044974faf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v3.1.2/wp-linux-arm64.tar.gz"
      sha256 "3a90a10061b66dccede6398b9a38388a2acca1c9505b01057c373157f5cdbf71"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v3.1.2/wp-linux-x64.tar.gz"
      sha256 "aefecc72e3d10fbeb8696401f1cd03fafd3a591c2b5155371a8617f6b100d1a7"
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
    root_url "https://github.com/tig/winprint/releases/download/v3.1.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f70a4e484a28331ce712e13232fe3c55420f8dea4e80a19f8c04a4b1c2e9fc3"
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
