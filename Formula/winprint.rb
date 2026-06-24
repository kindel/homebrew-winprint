# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.15/wp-osx-arm64.tar.gz"
      sha256 "362881e8c2c3b6b503d218c34106ec89d78e44381ed8d9f8dd165661d46b7eb8"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.15/wp-osx-x64.tar.gz"
      sha256 "374cc44038a9373f317be873437e4190ad36b93c6e56c2dc3d41505580e9bc54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.15/wp-linux-arm64.tar.gz"
      sha256 "e1f9a6d4c86430a1eec39197234d1ad8a98ad7f42a50a1513471379f63aa13fb"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.15/wp-linux-x64.tar.gz"
      sha256 "e06cbc46d235d23c754df77c3d36fcd52a64a0d6055ee784f42c634522e79f3f"
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
