import Cocoa


extension NSButton {
    func YDButtonStyle() {
        self.bezelStyle = .roundRect
        self.layer?.cornerRadius = 8
        self.layer?.borderWidth = 13.0
        self.layer?.borderColor = CGColor(red: 0.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        if #available(OSX 10.12.2, *) {
            self.bezelColor = NSColor.yellow
        }
    }
}
