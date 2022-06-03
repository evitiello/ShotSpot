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
		var urls: [URL]? = FileManager.default.urls(for: .desktopDirectory)
		
		guard let cleanURLs = urls else { return }
		
		//self.all = urls.map { Folder(url: $0[0]) }

		self.all = [
			Folder(url: URL(fileURLWithPath: "/Library")),
			Folder(url: URL(fileURLWithPath: "/Library")),
			Folder(url: URL(fileURLWithPath: "/Library"))
		]
	}
}


/// A Folder.
struct Folder {
	
	/// The location of the folder
	var url: URL = URL(fileURLWithPath: "/Library")
	
	/// The name to display for this folder
	var name = "BLAH"
	
	/// A unique identifier for this folder
	var id = UUID()
	
	/// Changes the folder that screenshots are saved to to this folder.
	/// - Returns: whether the action completed successfully or not
	func setAsScreenshotFolder() -> Bool {
		//defaults write com.apple.screencapture location ~/Desktop/Screen\ Shots
		return true
	}
}
