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

  on_macos do
    on_arm do
      resource "asimov-repository-cli" do
        url "https://github.com/asimov-platform/asimov-repository-cli/releases/tag/25.0.0-dev.1/asimov-macos-arm.gz"
        sha256 "64941269d9bcd8a19c2b00877da71e252ddf9f05a7ccdcfc3fa79eb02b9b4ce0"
      end
    end

    on_intel do
      resource "asimov-repository-cli" do
        url "https://github.com/asimov-platform/asimov-repository-cli/releases/tag/25.0.0-dev.1/asimov-macos-x86.gz"
        sha256 "501c312b5bfce96bba454591e3fcae3735d2dcc743bfdfbd11896fc517c97f21"
      end
    end
  end

  on_linux do
    on_arm do
      resource "asimov-repository-cli" do
        url "https://github.com/asimov-platform/asimov-repository-cli/releases/tag/25.0.0-dev.1/asimov-linux-arm-gnu.gz"
        sha256 "dc553524084f5d1f4016dcaaeee5e6e637a7beea4456d1a320d07837649dd133"
      end
    end

    on_intel do
      resource "asimov-repository-cli" do
        url "https://github.com/asimov-platform/asimov-repository-cli/releases/tag/25.0.0-dev.1/asimov-linux-x86-gnu.gz"
        sha256 "cf0e9a64019060dced69553f2805772377299000092bd97ed32b7b6c6d924a8d"
      end
    end
  end

  def install
    system "cargo", "install", *std_cargo_args

    # Process each resource
    resources.each do |r|
      r.stage do
        # chmod 0755, r.name
        libexec.install r.name
      end
    end
  end

  test do
    system bin/"asimov", "--version"

    # Test that all resources exist
    resources.each do |r|
      assert_path_exists libexec/r.name
    end
  end
end
