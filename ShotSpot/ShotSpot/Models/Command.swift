//
//  Command.swift
//  ShotSpot
//
//  Created by Eric Vitiello on 6/7/22.
//

import Foundation

/// Encapsulates a single executable command.
class Command {
	
	/// Executes a command, and returns she stdout and stderr output as a string.
	/// - Parameters:
	///   - command: The executable to run, i.e. "/bin/bash"
	///   - arguments: An array of arguments to pass to the executable. "--foo bar blah blah" would be ["-foo","bar","blah","blah"]
	/// - Returns: A string containing all STDOUT and STDERR output from the executable.
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
