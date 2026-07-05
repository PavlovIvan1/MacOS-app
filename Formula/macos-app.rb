class MacosApp < Formula
  desc "Простое SwiftUI macOS-приложение (Hello, World! / Привет!)"
  homepage "https://github.com/PavlovIvan1/MacOS-app"
  url "https://github.com/PavlovIvan1/MacOS-app/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4936b4b661edd1dcc95633bfbb603a2a3def39bd592f9971ddcf9aa1bcf234be"
  license "MIT"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/HelloWorldApp" => "macos-app"
  end

  test do
    assert_predicate bin/"macos-app", :exist?
  end
end
