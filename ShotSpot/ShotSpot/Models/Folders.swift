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
	var url: URL = URL(fileURLWithPath: "/Library")
	var name = "BLAH"
	var id = UUID()
}
