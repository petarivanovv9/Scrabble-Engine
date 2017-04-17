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


  let boardSectionStartIndex = lines.index(of: "--BOARD--")!
  let lettersSectionStartIndex = lines.index(of: "--LETTERS--")!


  // ====EXTRACT BOARD====

  let boardSize = lines[boardSectionStartIndex+1].components(separatedBy: " ").map { Int($0) ?? 0 }
  print(boardSize)

  // bonuses = [ (Coordinates: (Int, Int), Type: String, Points: Int) ]

  var bonuses : [((Int, Int), String, Int)] = [((Int, Int), String, Int)]()

  for l in lines[boardSectionStartIndex+2...lettersSectionStartIndex-1] {
    let line = l.components(separatedBy: " ")
    let row = Int(line[0]) ?? 0
    let col = Int(line[1]) ?? 0
    let coordinates = (row, col)
    let type = line[2]
    let multiplyBy = Int(line[3]) ?? 0
    bonuses.append(coordinates, type, multiplyBy)
  }
  print(bonuses)

  // ====END, EXTRACT BOARD====


  // ====EXTRACT LETTERS====

  // letters = [ (Letter: Character, Occurences: Int, Points: Int) ] -> [ ("A", 8, 1), ("Б", 3, 2)]

  var letters : [(Character, Int, Int)] = [(Character, Int, Int)]()


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
