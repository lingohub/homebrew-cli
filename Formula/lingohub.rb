class Lingohub < Formula
  desc "Command-line client, terminal dashboard and MCP server for the LingoHub API"
  homepage "https://lingohub.com"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.1/lingohub-aarch64-apple-darwin.tar.gz"
      sha256 "32de21fb5b2a019d663e387fbdf356cc73f36bdbdeec493fe9181ff872ef2f1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.1/lingohub-x86_64-apple-darwin.tar.gz"
      sha256 "43096cdc353e1fc16a40fe639082f697068f45255f166c580f98deefd9ad8f45"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.1/lingohub-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0279fd695dd70c767464fda77931eda66afbb2afadd1393de63e51d145c78c7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.1/lingohub-x86_64-unknown-linux-musl.tar.gz"
      sha256 "961c4122e93b0d72617b2b0d3f74fd1bfcd34a96286e9fe69d41e22d13329418"
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
