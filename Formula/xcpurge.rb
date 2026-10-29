class Xcpurge < Formula
  desc "Find unused assets, localized strings and files in Xcode/SwiftPM projects"
  homepage "https://github.com/iasaeed/xcpurge"
  url "https://github.com/iasaeed/xcpurge/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7c37e5c102484e3cde0df60ad6f6f74192c988c8ce8b1b52ff666e262f6207ce"
  license "MIT"
  head "https://github.com/iasaeed/xcpurge.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/xcpurge"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/xcpurge --version")
  end
end
