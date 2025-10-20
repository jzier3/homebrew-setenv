class Setenv < Formula
  desc "Simple CLI to manage persistent environment variables in terminal sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/setenv/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "221700a244495bc93dbc139a9ce5132ce1c58b063fb92b229dd1e4fea186d9f6"
  license "MIT"

  def install
    bin.install "bin/setenv"
  end

  test do
    system "#{bin}/setenv", "view"
  end
end

