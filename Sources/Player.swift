import Foundation

class Player {
  let name: String
  var score: Int = 0

  init(name: String) {
    self.name = name
  }

  func updateScore(score: Int) {
    // Remark: score should be always positive
    self.score += score
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
