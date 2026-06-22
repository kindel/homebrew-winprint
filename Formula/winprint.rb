# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the standalone free TUI (`wp`) — used
# on Linux and for CLI-only macOS installs. The free MAUI GUI ships as the tap's *cask*
# (packaging/homebrew/Casks/winprint.rb), which on macOS also embeds `wp`; the cask therefore
# conflicts with this formula (both provide `wp`).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.8/wp-osx-arm64.tar.gz"
      sha256 "f20a26cfa36529787567286494c9b2a153bd1c900a2fad2d4e5cb620cb44e2c1"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.8/wp-osx-x64.tar.gz"
      sha256 "e42d717d743f460729fec87e9832341e46da6768b0f5194bdee4a9df29ec1961"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.8/wp-linux-arm64.tar.gz"
      sha256 "bb0a45ddb16ea244d5b6359d91fa7ce9a35cc86a110a7e4eb636511687fdd95b"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.8/wp-linux-x64.tar.gz"
      sha256 "5a2866ca85c7c35768710c1c70a5ca5fbddc0ca4b16caeca39300786791ba17d"
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
