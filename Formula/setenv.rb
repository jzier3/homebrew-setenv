class Setenv < Formula
  desc "Simple CLI to manage persistent environment variables in terminal sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/setenv/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "19e2d5141850e4803f43018e53da655dd23c7fdf1518e6f79d242b08646c7fc6"
  license "MIT"

  def install
    bin.install "bin/setenv"
  end

  test do
    system "#{bin}/setenv", "view"
  end
end

