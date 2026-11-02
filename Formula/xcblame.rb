class Xcblame < Formula
  desc "Measure, explain and fix Xcode build time, locally and in CI"
  homepage "https://github.com/iasaeed/homebrew-tap"
  version "0.4.0"
  url "https://github.com/iasaeed/homebrew-tap/releases/download/xcblame-v0.4.0/xcblame-0.4.0-macos-universal.tar.gz"
  sha256 "20aa1ea0dcbe82841389cc848b0622b78430747b36e1f4052c401f3dfbc02c12"

  depends_on macos: :sonoma

  def install
    bin.install "xcblame"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xcblame --version")
  end
end
