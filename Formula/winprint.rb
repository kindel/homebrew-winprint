# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.13/wp-osx-arm64.tar.gz"
      sha256 "2bc36b3b7c3bc64e3523ba926dd729ef5a58583fd9485539b383a7df596845cd"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.13/wp-osx-x64.tar.gz"
      sha256 "a2255b69d51ea43dbc2b48748e6ef0ef8c47439ce90dcdf159430392ef84daf7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.13/wp-linux-arm64.tar.gz"
      sha256 "5362e0b4de891bd14f73186f2b78b0eb446afbd011e4c1d2d5e3d160a06c920c"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.13/wp-linux-x64.tar.gz"
      sha256 "7e7e1010d50997878a1951d6c2b2ed2a75c9a0e623ba46759bc95348b000c680"
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
