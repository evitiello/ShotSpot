//
//  MeetingRow.swift
//  WebexMenuBar
//
//  Created by Eric Vitiello on 10/23/20.
//

import SwiftUI
import Combine
import EventKit
import Cocoa

struct FolderRow: View {
	@ObservedObject var folder: Folder
	@ObservedObject var folders: Folders

	let columns = [
		GridItem(.fixed(20), alignment: .topLeading),
		GridItem(.flexible(), alignment: .topLeading)
	]
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .leading) {
			Image(systemName: folder.icon).foregroundColor(Color.blue).font(.system(size: 14))
			Text(folder.name).font(.system(size: 14))
		}
		.padding(1)
		.onTapGesture {
			self.folders.deselectAll()
			let setResult = folder.setAsScreenshotFolder()
			
			// need to handle error case here.
			if (setResult) {
				
			} else {
				
			}
		}
	}
}

struct FolderRow_Previews: PreviewProvider {
	static var previews: some View {
		let folders = Folders()
		FolderRow(folder: folders.all[0], folders: folders)
	}
}
