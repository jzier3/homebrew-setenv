class Setenv < Formula
  desc "CLI tool to manage global environment variables across shell sessions"
  homepage "https://github.com/jzier3/setenv"
  url "https://github.com/jzier3/setenv/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "4769f5e1d7f94683d35b6e89bcbf2bba28baadb05a7a647ed835c1f642b78a4b"
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
      Add ONE of the following to your shell config:

      Zsh (~/.zshrc):
        source "#{opt_prefix}/setenv_zsh_hook.sh"

      Bash (~/.bashrc or ~/.bash_profile):
        source "#{opt_prefix}/setenv_bash_hook.sh"

      Then restart your shell or run:
        source ~/.zshrc    # or source ~/.bashrc

      Your variables live in ~/.setenv/env.sh and auto-reload on change.
    EOS
  end

  test do
    system "#{bin}/setenv", "view"
  end
end
