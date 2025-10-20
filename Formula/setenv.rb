class Setenv < Formula
  desc "CLI tool to manage global environment variables across shell sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/homebrew-setenv/archive/refs/tags/v1.0.17.tar.gz"
  sha256 "634f08d23de2bfbefb52ec4c11da6584fd1353a7bbc2fe1de4cb688849a1af27"
  license "MIT"

  def install
    bin.install "bin/setenv"

    # Create hook script
    (prefix/"setenv_zsh_hook.sh").write <<~EOS
      # --- setenv hook (auto-loaded by zsh) ---
      export SETENV_HOME="${HOME}/.setenv"
      export SETENV_FILE="${SETENV_HOME}/env.sh"
      mkdir -p "$SETENV_HOME"
      [ -f "$SETENV_FILE" ] && . "$SETENV_FILE"

      setenv_precmd() {
        local m
        m=$(stat -f %m "$SETENV_FILE" 2>/dev/null || echo 0)
        if [ "$SETENV_MTIME" != "$m" ]; then
          SETENV_MTIME="$m"
          [ -f "$SETENV_FILE" ] && . "$SETENV_FILE"
        fi
      }
      precmd_functions+=setenv_precmd
      # --- end setenv hook ---
    EOS
  end


def caveats
  <<~EOS
    Please run:
      setenv init
    Your variables live in ~/.setenv/env.sh and auto-reload on change.
        To reload vars in an existing shell after updating them in a DIFFERENT session, simple run setenv.

    🧹 To completely remove setenv and its data after uninstalling:
            rm -rf "$HOME/.setenv"
  EOS
end

  test do
    system "#{bin}/setenv", "view"
  end
end

