import Foundation

class Tile: CustomStringConvertible {
  let letter: Character
  let score: Int

  init(letter: Character, score: Int = 0) {
      self.letter = letter
      self.score = score
  }

  var description: String {
    return "\(letter) with \(score)"
  }
}

class Player: CustomStringConvertible {
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

  var description: String {
    return "\(name) with \(score)"
  }
}

var petar = Player(name: "Petar Ivanov")
petar.updateScore(score: 10)
print(petar)
