class Xcblame < Formula
  desc "Measure, explain and fix Xcode build time, locally and in CI"
  homepage "https://github.com/iasaeed/homebrew-tap"
  version "0.5.0"
  url "https://github.com/iasaeed/homebrew-tap/releases/download/xcblame-v0.5.0/xcblame-0.5.0-macos-universal.tar.gz"
  sha256 "4ccd5b847dbdc5b2b070d4e2c61aef086269d8261fafb4b35ad98009402c95e6"

  depends_on macos: :sonoma

  def install
    bin.install "xcblame"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xcblame --version")
  end
end
