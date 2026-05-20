class LostWindow < Formula
  desc "Recover lost macOS app windows and force them back onscreen"
  homepage "https://github.com/Majboor/lost-window"
  head "https://github.com/Majboor/lost-window.git", branch: "codex/shortcuts-brew-curl"

  # macOS-only: the core command drives the Accessibility API through `swift`.
  depends_on :macos

  def install
    libexec.install "bin"
    pkgshare.install "README.md"
    pkgshare.install "raycast"
    pkgshare.install "shortcuts"
    bin.write_exec_script libexec/"bin/lost-window"
  end

  def caveats
    <<~EOS
      Grant Accessibility permission to whichever app launches `lost-window`
      (Terminal, Raycast, or Shortcuts) under:
        System Settings -> Privacy & Security -> Accessibility

      To create native launcher apps for the Dock and the Shortcuts app:
        lost-window install-apps
    EOS
  end

  test do
    # An unknown subcommand prints the usage block and exits non-zero.
    assert_match "Usage", shell_output("#{bin}/lost-window __bad_command__ 2>&1", 1)
  end
end
