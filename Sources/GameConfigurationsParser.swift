import Foundation


class GameConfigurationsParser {

  // TODO move parsing logic for board and letters here ???

  let filename : String
  let file : String

  init(filename: String) {
    self.filename = filename
    self.file = Helper.getEncodedFileContent(filename: filename)
  }

  func getLines() -> [String] {
    let lines = self.file.components(separatedBy: "\n")
    return lines
  }

}


// let path = FileManager.default.currentDirectoryPath
// let game_config_file = "\(path)/Sources/temp_game_configurations.txt"
//
// var config = GameConfigurationsParser(filename: game_config_file)
// print(config.getLines())
