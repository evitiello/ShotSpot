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
	var folder: Folder
	
	let columns = [
		GridItem(.fixed(20), alignment: .topLeading),
		GridItem(.fixed(20), alignment: .topLeading),
		GridItem(.flexible(), alignment: .topLeading)
	]
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .leading) {
			Image(systemName:"folder").foregroundColor(Color.blue)
			Image(systemName:"checkmark").foregroundColor(Color.blue)
			Text(folder.name)
		}
		.padding(2)
		.onTapGesture {
			let setResult = folder.setAsScreenshotFolder()
			// need to handle error case here.
			if (setResult) {
				
			} else {
				
			}
		}
	}
}

struct FolderyRow_Previews: PreviewProvider {
	static var previews: some View {
		FolderRow(folder: Folder())
	}
}
