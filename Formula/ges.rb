# Copyright 2026 Stephan Schlöpke
# SPDX-License-Identifier: Apache-2.0

class Ges < Formula
  desc "Portable, event-driven scripting language CLI"
  homepage "https://gameeventscript.org"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.2.0/ges-swift-0.2.0-osx-arm64.tar.gz"
      sha256 "976fc706cc7fbabc48a05e9723022863d053875d73ca328bb486252db84dd089"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.2.0/ges-swift-0.2.0-osx-x64.tar.gz"
      sha256 "25995f6ed297f2b2b537c28b046b122521c8bb3044c00e0d331be50dee870be5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.2.0/ges-swift-0.2.0-linux-arm64.tar.gz"
      sha256 "9428d6aebffbec13814916c462839d724934a2a41b243d9a81ee577bb1d3e76b"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.2.0/ges-swift-0.2.0-linux-x64.tar.gz"
      sha256 "f0d3de77b5f06bc43990cf9d630256a66828dd5cb2afed0054f56915e766e2f7"
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
