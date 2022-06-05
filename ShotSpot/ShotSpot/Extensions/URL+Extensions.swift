//
//  URL+Extensions.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/3/22.
//

import Foundation

extension URL {
	func isAlias() -> Bool {
		let	resources = try? self.resourceValues(forKeys: [.isAliasFileKey])

		guard let resources = resources, let isAliasFile = resources.isAliasFile else {
			print("Unable to unwrap resource values")
			return false
		}
		
		return isAliasFile
	}
}
