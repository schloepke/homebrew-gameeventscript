# Copyright 2026 Stephan Schlöpke
# SPDX-License-Identifier: Apache-2.0

class Ges < Formula
  desc "Portable, event-driven scripting language CLI"
  homepage "https://gameeventscript.org"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.6.0/ges-swift-0.6.0-osx-arm64.tar.gz"
      sha256 "2621dd8d67c14a4f7eb8a2e51617b8e731f9df38e9fe7a23f5c46fbf292952b9"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.6.0/ges-swift-0.6.0-osx-x64.tar.gz"
      sha256 "8cfd13c70e704df3ded898ea3be0dc64454a4283fa8d86a147b05134a3249ad3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.6.0/ges-swift-0.6.0-linux-arm64.tar.gz"
      sha256 "cb4fccdf99e7fc5ed1cc293d05218fb7922d4bb02a3ea36307d6228a7cd4c6e2"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.6.0/ges-swift-0.6.0-linux-x64.tar.gz"
      sha256 "d1a8663673c8b839cf12eb46ab6259fc7b74f4bb7fde0b3d3726ae8c7f067223"
    end
  end

  def install
    bin.install "bin/ges"
    pkgshare.install "LICENSE", "README.md", "build-info.json"
    pkgshare.install "licenses" if File.directory?("licenses")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ges --version")
    (testpath/"hello.ges").write <<~GES
      on Main(args) { emit ConsoleOut("homebrew-ok") }
    GES
    system bin/"ges", "check", testpath/"hello.ges", "--quiet"
    assert_equal "homebrew-ok\n", shell_output("#{bin}/ges run #{testpath}/hello.ges --quiet")
  end
end
