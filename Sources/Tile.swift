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


// var A_Tile = Tile(letter: "A", score: 3)
// print(A_Tile)
