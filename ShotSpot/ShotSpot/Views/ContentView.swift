//
//  ContentView.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/2/22.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var folders = Folders()
	@State var quitAlertShown = false
	
	var body: some View {
		listView
	}
	
	var listView: some View {
		ZStack {
			HStack {
				if self.folders.all.isEmpty {
					emptyView
				} else {
					folderListView
				}
			}
			
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						self.quitAlertShown = true
					}, label: {
						Image("power").resizable().frame(width: 12.0, height: 12.0)
					})
					.background(Color.init(.sRGB, red: 0.2, green: 0.2, blue: 0.2, opacity: 0))
					.cornerRadius(20)
					.shadow(color: Color.black.opacity(0.3), radius: 4, x: 2, y: 2)
					.padding()
				}
			}
			.alert(isPresented: $quitAlertShown) {
				Alert(title: Text("Quit"), message: Text("Are you really sure you want to do this?"), primaryButton: self.cancelButton, secondaryButton: self.quitButton)
			}
		}
	}
	
	var emptyView: some View {
		Text("No more meetings, congratulations!").padding(40)
	}
	
	var folderListView: some View {
		List(self.folders.all, id: \.id) { folder in
			FolderRow(folder: folder)
		}
	}
	
	var cancelButton: Alert.Button {
		Alert.Button.cancel(Text("I've made a horrible mistake"))
	}
	
	var quitButton: Alert.Button {
		Alert.Button.destructive(Text("Quit?")) {
			NSApplication.shared.terminate(self)
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
