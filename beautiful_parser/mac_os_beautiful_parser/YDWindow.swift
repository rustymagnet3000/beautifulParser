import Cocoa

class YDWindowController: NSWindowController {
    
    let winSize = NSSize(width: 600, height: 800 )
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        if let ydwindow = window, let screen = window?.screen {
        
            ydwindow.title = YDStaticStrings.ydWindowTitle
            ydwindow.minSize = NSSize(width: 200, height: 200 )
            let offsetFromLeftOfScreen: CGFloat = 400
            let offsetFromTopOfScreen: CGFloat = 200

            let screenRect = screen.visibleFrame
            let newOriginY = screenRect.maxY - ydwindow.frame.height - offsetFromTopOfScreen
            ydwindow.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOriginY))
        }
    }
}
