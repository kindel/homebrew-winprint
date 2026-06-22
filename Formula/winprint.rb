# Template rendered by the release pipeline (release.yml -> brew job) and pushed to the
# kindel/homebrew-winprint tap; the placeholders are filled with each stable release's
# version, download base URL, and per-arch SHA256s. This is the free TUI (`wp`); the free MAUI
# GUI ships alongside it as the tap's *cask* (packaging/homebrew/Casks/winprint.rb).
class Winprint < Formula
  desc "Advanced source code and text file printing terminal UI"
  homepage "https://github.com/kindel/winprint"
  version "2.6.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.5/wp-osx-arm64.tar.gz"
      sha256 "37d5befad1b0d437fa9cff23634961a0c0271237fec491dedf21976b68645af8"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.5/wp-osx-x64.tar.gz"
      sha256 "d2da8883acc1a908b6e55302e38b4e7c934d51de41209a44015d164da8bf6ce6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tig/winprint/releases/download/v2.6.5/wp-linux-arm64.tar.gz"
      sha256 "bfa93b5b65eb3f6c61c1ffc7f5c163c95cac977173cbb68f87fb40f1fdc1b686"
    end
    on_intel do
      url "https://github.com/tig/winprint/releases/download/v2.6.5/wp-linux-x64.tar.gz"
      sha256 "ea233ce0bbb292a919366a23c7976ad7654ca8d2b18d5ffd956b714f689e22f0"
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
