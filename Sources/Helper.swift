import Foundation

struct GameConfiguration {
  var board_dims: (nrows: Int, ncols: Int) = (nrows: 0, ncols: 0)
  var tiles_occurences: [(Tile, Int)] = [(Tile, Int)]()
  var bonuses: [(coordinates: (Int, Int), bonusType: String, bonusMultiplier: Int)] = [((Int, Int), String, Int)]()
}

struct SavedGameData {
  var players: [Player] = [Player]()
  var turns: [(player: Player, start_pos: (Int, Int), direction: Direction, word: String)] = [(Player, (Int, Int), Direction, String)]()
}

func getLetterScore(_ tiles_occurences : [(Tile, Int)], _ letter: Character) -> Int {
  for item in tiles_occurences {
    if item.0.letter == letter {
      return item.0.score
    }
  }
  return 1
}
