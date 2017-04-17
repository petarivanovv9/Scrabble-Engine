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

var A_Tile = Tile(letter: "A", score: 3)
print(A_Tile)
