# Copyright 2026 Stephan Schlöpke
# SPDX-License-Identifier: Apache-2.0

class Ges < Formula
  desc "Portable, event-driven scripting language CLI"
  homepage "https://gameeventscript.org"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.4.0/ges-swift-0.4.0-osx-arm64.tar.gz"
      sha256 "075cedca0fa46bbdf672bfe1b8e0fe63621b73dccd32143bfe5477f6c397f04d"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.4.0/ges-swift-0.4.0-osx-x64.tar.gz"
      sha256 "1e2cbfaa087fbaa8efabc193238c1491a60ccd77105701bd89225193ee223665"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.4.0/ges-swift-0.4.0-linux-arm64.tar.gz"
      sha256 "f32c70a01c068f5e8243194ec6d4ef44189f943a34c2b36d2617496f7fa5e2f0"
    end
    on_intel do
      url "https://github.com/schloepke/GameEventScript/releases/download/0.4.0/ges-swift-0.4.0-linux-x64.tar.gz"
      sha256 "b89816a24fda7d2f848f9a5f9e3d550fdee361c37adaceebe6ff82562edd529b"
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
