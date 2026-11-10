class Lingohub < Formula
  desc "Command-line client, terminal dashboard and MCP server for the LingoHub API"
  homepage "https://lingohub.com"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.3/lingohub-aarch64-apple-darwin.tar.gz"
      sha256 "328f2aa671d3e333371c2944d7b9557da5297ddbc2354f4cb84840d3c34726ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.3/lingohub-x86_64-apple-darwin.tar.gz"
      sha256 "f89483c2f5476f12bbb3cc834c8688199a3bbc6d19d04a04b9fa69a107891ab8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.3/lingohub-aarch64-unknown-linux-musl.tar.gz"
      sha256 "687f94fb4b74b2ad4307cc28e26d5f6cd80ebad6d7d886c5c37f0c7eee61c8d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.3/lingohub-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4245707c461387c13e7b62f515354b2330dcd61221ac3b917773596f4bb53ec3"
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
