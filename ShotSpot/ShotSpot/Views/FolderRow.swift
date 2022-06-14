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


/// A single row representing a folder.
struct FolderRow: View {
	@ObservedObject var folder: Folder
	@ObservedObject var folders: Folders
	@State private var alertVisible = false
	@State private var alertText = "UNDEFINED"

	/// The columns in the row
	let columns = [
		GridItem(.fixed(20), alignment: .topLeading),
		GridItem(.flexible(), alignment: .topLeading)
	]

	/// The main body
	var body: some View {
		LazyVGrid(columns: columns, alignment: .leading) {
			Image(systemName: folder.icon).foregroundColor(Color.blue).font(.system(size: 14))
			Text(folder.name).font(.system(size: 14))
		}
		.padding(1)
		.onTapGesture {
			self.folders.deselectAll()
			let setResult = folder.setAsScreenshotFolder()

			if (!setResult) {
				self.alertText = "Unable to set folder.\n See Console for details."
				self.alertVisible = true
			}
		}
		.alert(self.alertText, isPresented: $alertVisible) {
			Button("OK", role: .cancel) { self.alertVisible = false }
		}
	}
}


/// Preview definition for the FolderRow
struct FolderRow_Previews: PreviewProvider {
	static var previews: some View {
		let folders = Folders()
		FolderRow(folder: folders.all[0], folders: folders)
	}
}
