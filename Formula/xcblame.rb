class Xcblame < Formula
  desc "Measure, explain and fix Xcode build time, locally and in CI"
  homepage "https://github.com/iasaeed/homebrew-tap"
  version "0.6.0"
  url "https://github.com/iasaeed/homebrew-tap/releases/download/xcblame-v0.6.0/xcblame-0.6.0-macos-universal.tar.gz"
  sha256 "2a78380c16e425ad240c03ddec471fb3f507384cc91212f9b50587bbe20a59ef"

  depends_on macos: :sonoma

  def install
    bin.install "xcblame"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xcblame --version")
  end
end
