import Foundation


func getLetterScore(tiles_occurences : [(Tile, Int)], letter: Character) -> Int {
  for item in tiles_occurences {
    if item.0.letter == letter {
      return item.0.score
    }
  }
  return 1
}


do {
  let path = FileManager.default.currentDirectoryPath
  let game_config_file = "\(path)/Sources/game_configurations.txt"
  let saved_game_file  = "\(path)/Sources/saved_game.txt"

  var game_config = Parser.parseGameConfiguration(path: game_config_file)!
  print("[game_config]")
  print(game_config)
  print("\n")

  var saved_game_data = Parser.parseSavedGameData(path: saved_game_file)!
  print("[saved_game_data]")
  print(saved_game_data)
  print("\n")



  //////////////
  // THE GAME

  // Rack class to store the tiles

  // на всеки ход:
  //  - дали може да се изпише думата ( за място, началото на дъската, наличие на плочки и т.н )
  //  - смятам точките които ще бъдат добавени на съответния игра
  //  - премахвам използваните плочки
  //  - добавям точките и "слагам" плочките в/у дъската



} catch let error {
  print(error)
  print("Something went wrong! Try again!")
}
