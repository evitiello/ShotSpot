//
//  Filemanager+Extensions.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/2/22.
//

import Foundation

extension FileManager {
	/// Returns an array of URLs for the given directory.
	/// - Parameters:
	///   - directory: a FileManager.SearchPathDirectory
	///   - skipsHiddenFiles: include hidden files or not?
	/// - Returns: Returns an array of URLs for the given directory.
	func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
		let documentsURL = urls(for: directory, in: .userDomainMask)[0]
		let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
		return fileURLs
	}
}
