import Foundation


class Parser {

  static func getEncodedFileContent(filename: String) -> String? {
    var file : String? = nil
    do {
      file = try String(
        contentsOfFile: filename,
        encoding: String.Encoding.utf8
      )
    } catch let error {
      print(error)
    }
    return file
  }

  static func getLines(file: String) -> [String] {
    let lines = file.components(separatedBy: "\n")
    return lines
  }

  static func removeUnnecessaryLines(lines: [String]) -> [String] {
    return lines.filter { $0.isEmpty == false }.filter { $0[$0.startIndex] != "#" }
  }

}
