cask "macos-app" do
  version "1.2.0"
  sha256 "88746b04f31ce6d6881cf172c0b2ef35aac192e0f0062cca4368aeac2a92583b"

  url "https://github.com/PavlovIvan1/MacOS-app/archive/refs/tags/v#{version}.tar.gz"
  name "HelloWorldApp"
  desc "Простое SwiftUI macOS-приложение (Hello, World! / Привет!)"
  homepage "https://github.com/PavlovIvan1/MacOS-app"

  depends_on macos: :monterey

  preflight do
    system_command "/usr/bin/swift",
                    args: ["build", "-c", "release", "--package-path", staged_path.to_s],
                    print_stdout: true

    app_dir = staged_path/"HelloWorldApp.app"
    (app_dir/"Contents/MacOS").mkpath
    (app_dir/"Contents/Resources").mkpath

    system_command "/bin/cp",
                    args: [staged_path/".build/release/HelloWorldApp", app_dir/"Contents/MacOS/HelloWorldApp"]
    system_command "/bin/cp",
                    args: [staged_path/"Resources/AppIcon.icns", app_dir/"Contents/Resources/AppIcon.icns"]

    File.write(app_dir/"Contents/Info.plist", <<~PLIST)
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
          <string>#{version}</string>
          <key>CFBundleVersion</key>
          <string>1</string>
          <key>LSMinimumSystemVersion</key>
          <string>12.0</string>
          <key>NSHighResolutionCapable</key>
          <true/>
      </dict>
      </plist>
    PLIST
  end

  app "HelloWorldApp.app"
end
