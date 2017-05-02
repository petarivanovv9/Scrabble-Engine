import Foundation

class Tile {
  let letter: Character
  let score: Int

  init(letter: Character, score: Int) {
      self.letter = letter
      self.score = score
  }
}

extension Tile: CustomStringConvertible {
  var description: String {
    return "\(letter)-->\(score)"
  }
}
