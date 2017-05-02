import Foundation

struct GameConfiguration {
  var board_dims: (nrows: Int, ncols: Int) = (nrows: 0, ncols: 0)
  var tiles_occurences: [(Tile, Int)] = [(Tile, Int)]()
  var bonuses: [(coordinates: (Int, Int), bonusType: String, bonusMultiplier: Int)] = [((Int, Int), String, Int)]()
}

struct GameData {
  var players: [Player] = [Player]()
}
