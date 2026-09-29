# Copyright 2026 Stephan Schlöpke
# SPDX-License-Identifier: Apache-2.0

class Ges < Formula
  desc "Portable, event-driven scripting language CLI"
  homepage "https://gameeventscript.org"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.3.0/ges-swift-0.3.0-osx-arm64.tar.gz"
      sha256 "ebadfee9ffde3abc43a2266acf54b4fe72dc2ba7625ef5e326a51acc7fcfdbcd"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.3.0/ges-swift-0.3.0-osx-x64.tar.gz"
      sha256 "a4fb8d7ab68046ddf47ddbd90529c792eb4c7e917981605837c73ab60c6d6a7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.3.0/ges-swift-0.3.0-linux-arm64.tar.gz"
      sha256 "4523a6e1cb4d7d9bd66ba2c82c08ba49dc85783ddeaa0fcbee64c9b859eb0e4c"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.3.0/ges-swift-0.3.0-linux-x64.tar.gz"
      sha256 "10fc7510df6a91efd987b723550f107c592092564ae52fe89624c95bb9f7f143"
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
