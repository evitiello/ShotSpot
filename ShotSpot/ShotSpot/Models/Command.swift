//
//  Command.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/7/22.
//

import Foundation

class Command {
	static func Execute(command: String, arguments: [String]) -> String? {
		let task = Process()
		task.launchPath = command
		task.arguments = arguments
		
		let pipe = Pipe()
		task.standardOutput = pipe
		task.standardError = pipe
		task.launch()
		task.waitUntilExit()
		
		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
		return output
	}
}
