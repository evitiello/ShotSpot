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
	func setAsScreenshotFolder() -> Bool {
		//defaults write com.apple.screencapture location ~/Desktop/Screen\ Shots
		let task = Process()
		task.launchPath = "/usr/bin/defaults"
		task.arguments = ["write","com.apple.screencapture","location",self.url.path]
		
		let pipe = Pipe()
		task.standardOutput = pipe
		task.standardError = pipe
		task.launch()
		task.waitUntilExit()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)
		
		if (output == "" ) {
			return true
		} else {
			print("ERROR FROM defaults write: \(String(describing: output))")
			return false
		}
	}
}
