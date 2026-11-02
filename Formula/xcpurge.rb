class Xcpurge < Formula
  desc "Find unused assets, localized strings and files in Xcode/SwiftPM projects"
  homepage "https://github.com/iasaeed/xcpurge"
  url "https://github.com/iasaeed/xcpurge/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "ea5e73133ace4aefceed21361b72c231b1c65fbf1a74992a0d9a71b9750a946e"
  license "MIT"
  head "https://github.com/iasaeed/xcpurge.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/xcpurge"
  end

  test do
    assert_match "0.6.1", shell_output("#{bin}/xcpurge --version")
  end
end
