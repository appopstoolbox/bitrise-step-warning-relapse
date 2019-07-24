#!/usr/bin/swift

import Foundation

struct XCPrettyJSON : Codable {
  
  struct XCPrettyJSONError  : Codable {
    let file_name : String
    let file_path : String
    let reason : String
    let line : String
    let cursor : String
  }
  
  let warnings : [XCPrettyJSONError]
  let ld_warnings : [XCPrettyJSONError]
  let compile_warnings : [XCPrettyJSONError]
//  let errors : [XCPrettyJSONError]
//  let compile_errors : [XCPrettyJSONError]
//  let file_missing_errors : [XCPrettyJSONError]
//  let undefined_symbols_errors : [XCPrettyJSONError]
//  let duplicate_symbols_errors : [XCPrettyJSONError]
//  let tests_failures : [XCPrettyJSONError]
//  let tests_summary_messages : [XCPrettyJSONError]
}

func extractNumberOfWarning(_ args: [String]) {
  
  // Expected input: JSON file path (ex: result.json)
  guard args.count == 2 else {
    print("👉 Usage: ./XCPrettyJSONExtractNumberOfWarning.swift result.json")
    exit(EXIT_FAILURE)
  }
  
  guard let jsonData = FileManager.default.contents(atPath: args[1]) else {
    print("👉 Failure because JSON file is UNREADABLE 💩")
    exit(EXIT_FAILURE)
  }
  
  if let parsedJSON = try? JSONDecoder().decode(XCPrettyJSON.self, from: jsonData) {
    var total = 0
    total += parsedJSON.compile_warnings.count
    total += parsedJSON.warnings.count
    total += parsedJSON.ld_warnings.count
    print("\(total)")
    exit(EXIT_SUCCESS)
  }
  
  print("👉 Failure because JSON file is UNREADABLE 💩")
  exit(EXIT_FAILURE)
}

extractNumberOfWarning(CommandLine.arguments)
