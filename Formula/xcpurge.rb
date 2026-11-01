class Xcpurge < Formula
  desc "Find unused assets, localized strings and files in Xcode/SwiftPM projects"
  homepage "https://github.com/iasaeed/xcpurge"
  url "https://github.com/iasaeed/xcpurge/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "46c709d563674c22a096440730f5566570493c51bc76916d9c23f364f82e734f"
  license "MIT"
  head "https://github.com/iasaeed/xcpurge.git", branch: "main"

  depends_on xcode: ["26.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/xcpurge"
  end

  test do
    assert_match "0.6.0", shell_output("#{bin}/xcpurge --version")
  end
end
