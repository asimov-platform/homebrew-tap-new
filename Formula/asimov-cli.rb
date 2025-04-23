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
      resource "asimov-dataset" do
        url "https://github.com/asimov-platform/asimov-dataset-cli/releases/download/25.0.0-dev.5/asimov-macos-arm.gz"
        sha256 "cf4f4b1058db1f5238df985b3958e596c6eea84c3f92f0d8f0f5a489174eefbf"
      end
      resource "asimov-module" do
        url "https://github.com/asimov-platform/asimov-module-cli/releases/download/25.0.0-dev.2/module-cli-macos-arm.gz"
        sha256 "39d3c86b017c0b51a263f946f44d398161f44920e3b224e8c718cca3f7cbd57d"
      end
      # resource "asimov-repository-cli" do
      #   url "https://github.com/asimov-platform/asimov-repository-cli/releases/download/25.0.0-dev.1/asimov-macos-arm.gz"
      #   sha256 "64941269d9bcd8a19c2b00877da71e252ddf9f05a7ccdcfc3fa79eb02b9b4ce0"
      # end
    end

    on_intel do
      resource "asimov-dataset" do
        url "https://github.com/asimov-platform/asimov-dataset-cli/releases/download/25.0.0-dev.5/asimov-macos-x86.gz"
        sha256 "ea11d213dc01c99171e456de94958acc37abe84992b1c234b48e75a85ad6497d"
      end
      resource "asimov-module" do
        url "https://github.com/asimov-platform/asimov-module-cli/releases/download/25.0.0-dev.2/module-cli-macos-x86.gz"
        sha256 "18b26b321279923109b5dc81d7c8cb3cb5db7179a5db6e27601849add9195c37"
      end
      # resource "asimov-repository-cli" do
      #   url "https://github.com/asimov-platform/asimov-repository-cli/releases/download/25.0.0-dev.1/asimov-macos-x86.gz"
      #   sha256 "501c312b5bfce96bba454591e3fcae3735d2dcc743bfdfbd11896fc517c97f21"
      # end
    end
  end

  on_linux do
    on_arm do
      resource "asimov-dataset" do
        url "https://github.com/asimov-platform/asimov-dataset-cli/releases/download/25.0.0-dev.5/asimov-linux-arm-gnu.gz"
        sha256 "83deb2d62df03a24e5f3965a9a137efe423714c9d852763f6223ff4dc96d33c0"
      end
      resource "asimov-module" do
        url "https://github.com/asimov-platform/asimov-module-cli/releases/download/25.0.0-dev.2/module-cli-linux-arm-gnu.gz"
        sha256 "b90bc4cda8f648b5d0f7863f141c9a314b4410edf40fd7b0f5a20c4c9aa01b30"
      end
      # resource "asimov-repository-cli" do
      #   url "https://github.com/asimov-platform/asimov-repository-cli/releases/download/25.0.0-dev.1/asimov-linux-arm-gnu.gz"
      #   sha256 "dc553524084f5d1f4016dcaaeee5e6e637a7beea4456d1a320d07837649dd133"
      # end
    end

    on_intel do
      resource "asimov-dataset" do
        url "https://github.com/asimov-platform/asimov-dataset-cli/releases/download/25.0.0-dev.5/asimov-linux-x86-gnu.gz"
        sha256 "abbcf6612278381d079e85b658cced97b47f71652437fa39e6eb8dc2423d6d6d"
      end
      resource "asimov-module" do
        url "https://github.com/asimov-platform/asimov-module-cli/releases/download/25.0.0-dev.2/module-cli-linux-x86-gnu.gz"
        sha256 "d8cb3ad98499d42ec4f89c6669264935a41b0583f6e3995b7e1382b73b654af6"
      end
      # resource "asimov-repository-cli" do
      #   url "https://github.com/asimov-platform/asimov-repository-cli/releases/download/25.0.0-dev.1/asimov-linux-x86-gnu.gz"
      #   sha256 "cf0e9a64019060dced69553f2805772377299000092bd97ed32b7b6c6d924a8d"
      # end
    end
  end

  def install
    system "cargo", "install", *std_cargo_args

    # Process each resource
    resources.each do |r|
      r.stage do
        chmod 0755, r.name
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
