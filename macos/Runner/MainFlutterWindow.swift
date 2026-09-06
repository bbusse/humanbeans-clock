import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    // Black until Flutter draws its first frame, matching the app background
    self.backgroundColor = .black

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
