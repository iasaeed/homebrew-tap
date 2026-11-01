class Xcpurge < Formula
  desc "Find unused assets, localized strings and files in Xcode/SwiftPM projects"
  homepage "https://github.com/iasaeed/xcpurge"
  url "https://github.com/iasaeed/xcpurge/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "698cef691e312214d939ea876c7d15ef6abf3a92e1c1ccd8ad06a54545034b59"
  license "MIT"
  head "https://github.com/iasaeed/xcpurge.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/xcpurge"
  end

  test do
    assert_match "0.5.0", shell_output("#{bin}/xcpurge --version")
  end
end
