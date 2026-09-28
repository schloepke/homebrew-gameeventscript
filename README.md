<!-- Copyright 2026 Stephan Schlöpke -->
<!-- SPDX-License-Identifier: Apache-2.0 -->

# GameEventScript Homebrew Tap

Install the native Swift CLI for macOS 15+ or Linux, on ARM64 or x86-64:

```sh
brew install schloepke/gameeventscript/ges
ges --version
```

No Swift toolchain or .NET runtime is required. Homebrew itself must already be installed.
The formula uses the immutable CLI archives from the
[GameEventScript releases](https://github.com/schloepke/GameEventScript/releases),
with SHA-256 verification.

## Update or uninstall

```sh
brew update
brew upgrade ges
brew uninstall ges
```

If you previously installed `ges` manually, check `which -a ges` to ensure your
PATH selects the intended installation. This tap does not remove other installations.

See [gameeventscript.org](https://gameeventscript.org) for documentation and guides.
Report language or CLI issues in [GameEventScript](https://github.com/schloepke/GameEventScript/issues);
report formula or installation issues in this repository.

## Maintaining a release

1. Publish and verify the four Swift CLI archives in an upstream GitHub release.
2. Update `Formula/ges.rb`: version, four tagged URLs, and all four SHA-256 values.
   Use the published `ges-cli-<version>-SHA256SUMS.txt`; never use development builds.
3. Open a pull request and let the macOS/Linux architecture matrix install and test it.
4. Merge after successful checks. Consumers receive the update through `brew update`.

This is a binary distribution formula in a project-owned tap, not a submission
to homebrew/core. The tap contains no CLI binaries and uses the same release
version as the upstream libraries.
