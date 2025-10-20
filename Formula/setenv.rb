class Setenv < Formula
  desc "Simple CLI to manage persistent environment variables in terminal sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/setenv/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  def install
    bin.install "bin/setenv"
  end

  test do
    system "#{bin}/setenv", "view"
  end
end

