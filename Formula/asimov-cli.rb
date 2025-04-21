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
      resource "asimov-test-cli" do
        url "https://github.com/asimov-platform/asimov-cli/releases/download/25.0.0-dev.4/asimov-macos-arm.gz"
        sha256 "e67ec61334647909fa1d405498ca42a6e7a9a96471a435ec5bbb7dc784c08ce4"
      end
    end

    on_intel do
      resource "asimov-test-cli" do
        url "https://github.com/asimov-platform/asimov-cli/releases/download/25.0.0-dev.4/asimov-macos-x86.gz"
        sha256 "eaaa532d63de98905367816b5ec6fad87815d2911d6d57bf7ddeec446f36bec5"
      end
    end
  end

  on_linux do
    on_arm do
      resource "asimov-test-cli" do
        url "https://github.com/asimov-platform/asimov-cli/releases/download/25.0.0-dev.4/asimov-linux-arm-gnu.gz"
        sha256 "ef21144725eeccd0618357f0bb4936d1653a8968bfa8b530fa2490685470dc33"
      end
    end

    on_intel do
      resource "asimov-test-cli" do
        url "https://github.com/asimov-platform/asimov-cli/releases/download/25.0.0-dev.4/asimov-linux-x86-gnu.gz"
        sha256 "6b6e54fd490e036d864158de7d4b19a248aaf64c926ff9d3daa9db0f463d6f9c"
      end
    end
  end

  def install
    system "cargo", "install", *std_cargo_args

    # Process each resource
    resources.each do |r|
      r.stage do
        source_file = File.basename(r.url).chomp(".gz")

        # chmod 0755, source_file

        libexec.install source_file => r.name
      end
    end
  end

  test do
    system bin/"asimov", "--version"

    # Test that all resources exist
    resources.each do |r|
      name = Pathname(r.name.chomp(".gz"))
      assert_path_exists libexec/name
    end
  end
end
