class Lingohub < Formula
  desc "Command-line client, terminal dashboard and MCP server for the LingoHub API"
  homepage "https://lingohub.com"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.0/lingohub-aarch64-apple-darwin.tar.gz"
      sha256 "b64eb5ebc5fbb6fa4ec02b2f4863de09aad2aafc0aface5dc6fbbbee806c7dba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.0/lingohub-x86_64-apple-darwin.tar.gz"
      sha256 "09ca67cb5bb2061c1b1169ed06ef6724a91f391f10147e0ca770db5329d5c141"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.0/lingohub-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1687e5ea634d72ce5c3c2293a976399b25ef749e4eb6e21a03588f67f6b26229"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.0/lingohub-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9d749a819fabfd1387d5ae31d4c6c3047cf9f975bb98230f5d08595a41712f05"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lingohub"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lingohub"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lingohub"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lingohub"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
