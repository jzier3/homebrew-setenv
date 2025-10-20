class Setenv < Formula
  desc "Simple CLI to manage persistent environment variables in terminal sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/setenv/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "94a00367a810e26966a0291a2200bdcbd62840e4924cc0603ec6482522d5f70a"
  license "MIT"

  def install
    bin.install "bin/setenv"
  end

  test do
    system "#{bin}/setenv", "view"
  end
end

