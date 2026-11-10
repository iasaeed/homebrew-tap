class Xcblame < Formula
  desc "Measure, explain and fix Xcode build time, locally and in CI"
  homepage "https://github.com/iasaeed/homebrew-tap"
  version "0.6.1"
  url "https://github.com/iasaeed/homebrew-tap/releases/download/xcblame-v0.6.1/xcblame-0.6.1-macos-universal.tar.gz"
  sha256 "3295e944574a111561f1ec3dca9e1c7bc4adf0592ee8fa7fee2455b0d0cab8cd"

  depends_on macos: :sonoma

  def install
    bin.install "xcblame"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xcblame --version")
  end
end
