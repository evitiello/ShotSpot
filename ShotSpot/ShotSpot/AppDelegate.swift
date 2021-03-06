//
//  AppDelegate.swift
//  WebexMenuBar
//
//  Created by Eric Vitiello on 10/23/20.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	
	var popover: NSPopover!
	var statusBarItem: NSStatusItem!
	
	func statusBarLogo() -> NSImage {
		let logo = NSImage(named: NSImage.Name("arrows"))

		let resizedLogo = NSImage(size: NSSize(width: 18, height: 18), flipped: false) { (dstRect) -> Bool in
			logo!.draw(in: dstRect)
			return true
		}
		
		return resizedLogo
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Create the SwiftUI view that provides the window contents.
		let contentView = ContentView()
		
		// Create the popover
		let popover = NSPopover()
		//popover.contentSize = NSSize(width: 300, height: 400)
		popover.behavior = .transient
		popover.contentViewController = NSHostingController(rootView: contentView)
		self.popover = popover
		
		self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
		if let button = self.statusBarItem.button {
			button.image = self.statusBarLogo()
			button.action = #selector(togglePopover(_:))
		}
	}
	
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
	@objc func togglePopover(_ sender: AnyObject?) {
		if let button = self.statusBarItem.button {
			if self.popover.isShown {
				self.popover.performClose(sender)
			} else {
				self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
				// Activate the popover
				self.popover.contentViewController?.view.window?.becomeKey()
			}
		}
	}
	
}

