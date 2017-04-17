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


  // ====EXTRACT BOARD====

  // bonuses = [ (Coordinates: (Int, Int), Type: String, Points: Int) ]

   


  // ====END, EXTRACT BOARD====


  // ====EXTRACT LETTERS====

  // letters = [ (Letter: Character, Occurences: Int, Points: Int) ] -> [ ("A", 8, 1), ("Б", 3, 2)]

  var letters : [(Character, Int, Int)] = [(Character, Int, Int)]()

  let lettersSectionStartIndex = lines.index(of: "--LETTERS--")!

  for l in lines[lettersSectionStartIndex+1...lines.count-1] {
    let line = l.components(separatedBy: " ")
    print(line)
    let letter = Character(line[0])
    let occurences = Int(line[1]) ?? 0
    let points = Int(line[2]) ?? 0
    letters.append((letter, occurences, points))
  }
  print(letters)

  // ====END, EXTRACT LETTERS====


} catch let error {
  print(error)
}
