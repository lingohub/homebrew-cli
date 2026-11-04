class Lingohub < Formula
  desc "Command-line client, terminal dashboard and MCP server for the LingoHub API"
  homepage "https://lingohub.com"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.1.0/lingohub-aarch64-apple-darwin.tar.gz"
      sha256 "9ce9ae4fbd0a4bae22443fd6cb62956aac78f399f4dbef6050e57e5629c87c46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.1.0/lingohub-x86_64-apple-darwin.tar.gz"
      sha256 "2567c2a5be28e1149275c9657939776920f4c4a2271a5d8262aefe6598739294"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.1.0/lingohub-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f606cd41f673e85a78d2661df3c1117d99a954a8cda55940560ed8679c989978"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lingohub/lingohub-cli/releases/download/v0.1.0/lingohub-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d0f63bbadda43e85ce5f91ca5053c36ec700640dcae8200a86c567e49eab450"
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
