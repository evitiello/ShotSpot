//
//  URL+Extensions.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/3/22.
//

import Foundation

extension URL {
	func isAlias() {
		self.resourceValues(forKeys: [.isAliasFileKey])
		
	}
}
