import Foundation


class Helper {

  static func getEncodedFileContent(filename: String) -> String {
    var file : String = ""
    do {
      file = try String(
        contentsOfFile: filename,
        encoding: String.Encoding.utf8
      )
    }
    catch let error {
      print(error)
    }
    return file
  }

}
