import Foundation

class Tile {
  let letter: Character
  let score: Int

  init(letter: Character, score: Int = 0) {
      self.letter = letter
      self.score = score
  }

  var representation: String {
    return "\(letter) with \(score)"
  }
}

// var A_Tile = Tile(letter: "A", score: 3)
// print(A_Tile.representation)
