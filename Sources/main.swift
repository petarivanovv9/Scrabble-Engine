import Foundation

let path = FileManager.default.currentDirectoryPath

let file = "\(path)/Sources/game_configurations.txt"

do {
  let gameConfigurations: String = try String(
    contentsOfFile: file,
    encoding: String.Encoding.utf8
  )
  var lines = gameConfigurations.components(separatedBy: "\n")

  // remove unnecessary lines like commented and empty one
  lines = lines.filter { $0.isEmpty == false }
  lines = lines.filter { $0[$0.startIndex] != "#" }
  print(lines)



} catch let error {
  print(error)
}
