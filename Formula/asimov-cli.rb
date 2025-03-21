class AsimovCli < Formula
  desc "ASIMOV Command-Line Interface (CLI)"
  homepage "https://github.com/asimov-platform/asimov-cli"
  url "https://github.com/imunproductive/asimov-cli/archive/refs/tags/25.0.0-dev.13.tar.gz"
  sha256 "87ad24988c4b3cb1913d9dcbb41c809975fcf15249fd1379a30b4c6fce9dfb05"
  license "Unlicense"
  head "https://github.com/asimov-platform/asimov-cli.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/asimov-platform/tap-new"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5ff8f14617fb484f08df0481a3f81f82d958747ef5fd4fae4f84a62b6c8b0245"
    sha256 cellar: :any_skip_relocation, ventura:       "c067c3221da8f574db8e1970030940d3bcb61774b1ee508b6a25f0498636f8e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b6380913e00672b8aa33ece38fc6ab318807a77146b6d7d1002d1debb6e7cfb"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"asimov", "--version"
  end
end
