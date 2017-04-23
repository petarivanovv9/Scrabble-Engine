import Foundation


class Player {
  let name: String
  var score: Int = 0
  var tiles: [Tile] = []
  // ??? maybe I should store the whole words ???

  init(name: String) {
    self.name = name
  }

  func updateScore(score: Int) {
    // Remark: score should be always positive
    self.score += score
  }

  func addTile(tile: Tile) {
    self.tiles.append(tile)
  }
}

extension Player: CustomStringConvertible {

  var description: String {
    return "\(name)-->\(score)"
  }
}

// var petar = Player(name: "Petar Ivanov")
// petar.updateScore(score: 10)
// print(petar)
