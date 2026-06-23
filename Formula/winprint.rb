# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.12"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.12/wp-osx-arm64.tar.gz"
      sha256 "b806cc986a85cab330d05096420dc3f60a0efa3e895c93ead12193c25bca113f"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.12/wp-osx-x64.tar.gz"
      sha256 "0640d661ac04ec417ef523e6c2df3a5d49c69ccefad82cdc68d6b888c400e13f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.12/wp-linux-arm64.tar.gz"
      sha256 "cd41ca4e63a9165255374d24a533e8354fc972882576ed7523c0fd24b9a55562"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.12/wp-linux-x64.tar.gz"
      sha256 "b85eddf080c5b276f7bab00dc3740ebeb946e48f942bb5af3aa6643fc5f00851"
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
