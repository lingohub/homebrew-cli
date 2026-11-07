class Lingohub < Formula
  desc "Command-line client, terminal dashboard and MCP server for the LingoHub API"
  homepage "https://lingohub.com"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.2/lingohub-aarch64-apple-darwin.tar.gz"
      sha256 "74a774016109e8b3d404753d9f22dcad4f3d055a942b994bd204d0df47c5b190"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.2/lingohub-x86_64-apple-darwin.tar.gz"
      sha256 "616f20dc27477894a3d3265ebb071caa21c6e4d064da4a876b40855a3b84f5fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.2/lingohub-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b912dd090a9ed5535318c5b4306977bdd8a8be611ace5d926e34d917d8a70528"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.2.2/lingohub-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6d5b1982780d6780b9acec726e39eb6d59a7106eaaa7f6db82049a096fc749d0"
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
