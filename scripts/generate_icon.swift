import AppKit

func drawIcon(size: CGFloat) -> NSImage {
    let image = NSImage(size: NSSize(width: size, height: size))
    image.lockFocus()

    let rect = NSRect(x: 0, y: 0, width: size, height: size)
    let path = NSBezierPath(roundedRect: rect, xRadius: size * 0.22, yRadius: size * 0.22)
    let gradient = NSGradient(colors: [
        NSColor(calibratedRed: 0.36, green: 0.2, blue: 0.85, alpha: 1),
        NSColor(calibratedRed: 0.95, green: 0.35, blue: 0.55, alpha: 1)
    ])
    gradient?.draw(in: path, angle: -45)

    let text = "Hi"
    let fontSize = size * 0.42
    let font = NSFont.systemFont(ofSize: fontSize, weight: .heavy)
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    let attrs: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: NSColor.white,
        .paragraphStyle: paragraph
    ]
    let attrString = NSAttributedString(string: text, attributes: attrs)
    let textSize = attrString.size()
    let textRect = NSRect(
        x: (size - textSize.width) / 2,
        y: (size - textSize.height) / 2 - size * 0.02,
        width: textSize.width,
        height: textSize.height
    )
    attrString.draw(in: textRect)

    image.unlockFocus()
    return image
}

func savePNG(_ image: NSImage, to path: String, size: CGFloat) {
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size), pixelsHigh: Int(size),
                                bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                                colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
    image.draw(in: NSRect(x: 0, y: 0, width: size, height: size))
    NSGraphicsContext.restoreGraphicsState()

    let pngData = rep.representation(using: .png, properties: [:])!
    try! pngData.write(to: URL(fileURLWithPath: path))
}

let outDir = CommandLine.arguments[1]
let sizes: [(CGFloat, String)] = [
    (16, "icon_16x16"), (32, "icon_16x16@2x"),
    (32, "icon_32x32"), (64, "icon_32x32@2x"),
    (128, "icon_128x128"), (256, "icon_128x128@2x"),
    (256, "icon_256x256"), (512, "icon_256x256@2x"),
    (512, "icon_512x512"), (1024, "icon_512x512@2x")
]

for (size, name) in sizes {
    let img = drawIcon(size: size)
    savePNG(img, to: "\(outDir)/\(name).png", size: size)
}

print("Icons generated in \(outDir)")
