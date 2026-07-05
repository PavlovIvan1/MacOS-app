class MacosApp < Formula
  desc "Простое SwiftUI macOS-приложение (Hello, World! / Привет!)"
  homepage "https://github.com/PavlovIvan1/MacOS-app"
  url "https://github.com/PavlovIvan1/MacOS-app/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "3f55a87cb04122f7d132786615ed484fc9733dec09b72d1fa506f391ffcb85ee"
  license "MIT"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"

    app = prefix/"HelloWorldApp.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath

    cp ".build/release/HelloWorldApp", app/"Contents/MacOS/HelloWorldApp"
    cp "Resources/AppIcon.icns", app/"Contents/Resources/AppIcon.icns"
    (app/"Contents/Info.plist").write <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>CFBundleExecutable</key>
          <string>HelloWorldApp</string>
          <key>CFBundleIconFile</key>
          <string>AppIcon.icns</string>
          <key>CFBundleIdentifier</key>
          <string>com.example.HelloWorldApp</string>
          <key>CFBundleName</key>
          <string>HelloWorldApp</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
          <key>CFBundleShortVersionString</key>
          <string>1.1</string>
          <key>CFBundleVersion</key>
          <string>1</string>
          <key>LSMinimumSystemVersion</key>
          <string>12.0</string>
          <key>NSHighResolutionCapable</key>
          <true/>
      </dict>
      </plist>
    EOS

  end

  def post_install
    system "ln", "-sf", opt_prefix/"HelloWorldApp.app", "/Applications/HelloWorldApp.app"
  end

  def caveats
    <<~EOS
      HelloWorldApp.app установлен в /Applications (символическая ссылка
      на #{opt_prefix}/HelloWorldApp.app) и доступен через Launchpad/Spotlight.

      При удалении формулы (`brew uninstall macos-app`) ссылку из
      /Applications нужно убрать вручную:
        rm /Applications/HelloWorldApp.app
    EOS
  end

  test do
    assert_predicate prefix/"HelloWorldApp.app/Contents/MacOS/HelloWorldApp", :exist?
  end
end
