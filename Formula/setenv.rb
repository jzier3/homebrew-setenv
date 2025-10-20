class Setenv < Formula
  desc "CLI tool to manage global environment variables across shell sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/setenv/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "REPLACE_WITH_REAL_SHA256"
  license "MIT"

  def install
    bin.install "setenv"

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
      🔧 To enable automatic loading of your setenv variables in Zsh,
      add the following line to your ~/.zshrc (if not already present):

        source "#{opt_prefix}/setenv_zsh_hook.sh"

      Then restart your terminal, or run:
        source ~/.zshrc

      Your environment variables are stored in ~/.setenv/env.sh
      and are auto-reloaded whenever they change.
    EOS
  end

  test do
    system "#{bin}/setenv", "view"
  end
end
