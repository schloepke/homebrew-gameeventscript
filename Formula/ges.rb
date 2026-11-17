# Copyright 2026 Stephan Schlöpke
# SPDX-License-Identifier: Apache-2.0

class Ges < Formula
  desc "Portable, event-driven scripting language CLI"
  homepage "https://gameeventscript.org"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.5.0/ges-swift-0.5.0-osx-arm64.tar.gz"
      sha256 "473f5937075835e2d00f07cbcc5220237e60c6d944cbadd0a44018eded9aa88a"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.5.0/ges-swift-0.5.0-osx-x64.tar.gz"
      sha256 "415f57d4aee3d524af478b26b22e4e3ee3cc74c24715c14d0f0b9d723c13351d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.5.0/ges-swift-0.5.0-linux-arm64.tar.gz"
      sha256 "594b0538e1a48fbd99605f7752a2a72ac1e35e9b6de666cf74fe8835d2ee87b5"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.5.0/ges-swift-0.5.0-linux-x64.tar.gz"
      sha256 "ea38032c874702bdf5443a3298bf009f58c41dd8a20e730eee3d4b827a82c0f2"
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
