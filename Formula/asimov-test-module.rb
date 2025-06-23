class AsimovCli < Formula
  desc "ASIMOV Test module"
  homepage "https://github.com/asimov-modules/asimov-test-module"
  url "https://github.com/asimov-modules/asimov-test-module/archive/refs/tags/0.0.2.tar.gz"
  version "0.0.2"
  license "Unlicense"
  head "https://github.com/asimov-modules/asimov-test-module.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # system bin/"asimov-test-emitter", "--version"
    # system bin/"asimov-test-runner", "--version"
  end
end
