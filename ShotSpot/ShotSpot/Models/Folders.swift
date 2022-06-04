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
		
		self.all = urls!.filter{ $0.hasDirectoryPath || $0. }.map { Folder(url: $0) }
	}
}


/// A Folder.
struct Folder {
	
	/// The location of the folder
	var url: URL = URL(fileURLWithPath: "/tmp")
	
	/// The name to display for this folder
	var name: String { self.url.lastPathComponent.capitalized }
	
	/// A unique identifier for this folder
	var id = UUID()
	
	/// Changes the folder that screenshots are saved to to this folder.
	/// - Returns: whether the action completed successfully or not
	func setAsScreenshotFolder() -> Bool {
		//defaults write com.apple.screencapture location ~/Desktop/Screen\ Shots
		return true
	}
}
