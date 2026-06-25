# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.7.0/wp-osx-arm64.tar.gz"
      sha256 "98a0daa1b3e0d63a1dc781e622ce5bec0674c78c62d66539e12a95e4b98a3428"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.7.0/wp-osx-x64.tar.gz"
      sha256 "69312a00a509c4f4c0714306606bf43bbeea9348018260576379bc92a640b241"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.7.0/wp-linux-arm64.tar.gz"
      sha256 "741801e4db3661a3a9bd6179b3beef502c9114a0a3a4792ea4ff32a8819b999e"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.7.0/wp-linux-x64.tar.gz"
      sha256 "fb5603cb18643b5a25c19fbf66387062989e6fc183a0ff6d51b0050f2f9b3e65"
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
