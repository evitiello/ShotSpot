//
//  Folders.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/2/22.
//

import Foundation
import Combine


/// Manager for folders
final class Folders: Combine.ObservableObject {
	@Published var all: [Folder] = []
	
	init() {
		let urls: [URL]? = FileManager.default.directoryURLs(for: .desktopDirectory)
		
		guard urls != nil else { return }
		
		self.all = urls!.filter{ $0.hasDirectoryPath || $0.isAlias() }.map { Folder(url: $0) }
		
		// Find out which folder is currently set
		let activeFolder = Folders.getActiveScreenshotsFolderFromSystem()!
		let folder = self.all.filter{ $0.url.path == activeFolder }
		if (folder.count > 0) {
			folder[0].setSelected()
		}
	}
	
	/// marks all folders as unselected.
	func deselectAll() {
		_ = self.all.map { $0.selected = false; $0.icon = "folder" }
	}
	
	/// Gets the active screenshots folder
	/// - Returns: the folder, or nil if not set.
	static func getActiveScreenshotsFolderFromSystem() -> String? {
		let output = Command.Execute(command: "/usr/bin/defaults",
									 arguments: ["read","com.apple.screencapture","location"])
		return output
	}
}


/// A Folder.
class Folder: Combine.ObservableObject {
	
	/// The location of the folder
	var url: URL = URL(fileURLWithPath: "/tmp")
	
	/// The name to display for this folder
	var name: String { self.url.lastPathComponent.capitalized }
	
	/// A unique identifier for this folder
	var id = UUID()
	
	/// Is this the selected folder
	@Published var selected = false
	
	/// Which icon is associated with this folder
	@Published var icon = "folder"
	
	init(url: URL) {
		self.url = url
	}
	
	/// sets this folder as selected
	func setSelected() {
		self.selected = true
		self.icon = "checkmark"
	}
	
	/// unsets selected state for this folder.
	func unsetSelected() {
		self.selected = false
		self.icon = "folder"
	}
	
	/// Changes the folder that screenshots are saved to to this folder.
	func setAsScreenshotFolder() -> Bool {
		let output = Command.Execute(command: "/usr/bin/defaults",
									 arguments: ["write","com.apple.screencapture","location",self.url.path])
		
		if (output != nil && output == "" ) {
			self.setSelected()
			let activeFolder = Folders.getActiveScreenshotsFolderFromSystem()
			if (self.url.path != activeFolder) {
				print("Screenshots folder WAS NOT set to: \(self.url.path), it is: \(activeFolder ?? "UNKNOWN"). It is unknown why this happened. Please dig into the console.")
				return false
			}
			print("Screenshots folder set to: \(activeFolder ?? "UNKNOWN")")
			return true
		} else {
			print("ERROR FROM defaults write: \(String(describing: output))")
			return false
		}
	}
}
