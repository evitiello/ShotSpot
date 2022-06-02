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
		GridItem(.fixed(70), alignment: .topLeading),
		GridItem(.flexible(), alignment: .topLeading)
	]
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .leading) {
			Image(systemName:"folder").foregroundColor(Color.blue)
			Text(folder.name)
//			VStack(alignment: .leading) {
//				Text(event.title).font(.system(size: 14))
//				Text("\(event.organizer()), \(event.totalAttendees())").foregroundColor(Color.gray)
//			}
//			.font(.system(size: 10))
		}
		.padding(2)
		.onTapGesture {
			//TODO: Implement the switching
			
//			if let urlString = event.webexLink() {
//				let url = URL(string: urlString)!
//				if NSWorkspace.shared.open(url) {
//					print("Browser was successfully opened")
//				}
//			}
		}
	}
}

struct FolderyRow_Previews: PreviewProvider {
	static var previews: some View {
		FolderRow(folder: Folder())
	}
}
