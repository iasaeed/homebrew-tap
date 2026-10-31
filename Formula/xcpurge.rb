class Xcpurge < Formula
  desc "Find unused assets, localized strings and files in Xcode/SwiftPM projects"
  homepage "https://github.com/iasaeed/xcpurge"
  url "https://github.com/iasaeed/xcpurge/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "e35398fbb8f53bc6f15c17a256ca1bd7ffdd2a1833cbb3edb1f21c467ab589c9"
  license "MIT"
  head "https://github.com/iasaeed/xcpurge.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/xcpurge"
  end

  test do
    assert_match "0.4.0", shell_output("#{bin}/xcpurge --version")
  end
end
