class Setenv < Formula
  desc "Simple CLI to manage persistent environment variables in terminal sessions"
  homepage "https://github.com/jzier/homebrew-setenv"
  url "https://github.com/jzier/homebrew-setenv/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "<TO_BE_FILLED>"
  license "MIT"

  def install
    bin.install "bin/setenv"
  end

  test do
    system "#{bin}/setenv", "view"
  end
end

