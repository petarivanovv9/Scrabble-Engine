import Foundation

class Board {
  var board: [[Character]]? = nil

  init(rows: Int, cols: Int) {
    board = Array(
      repeating: Array(repeating: " ", count: cols),
      count: rows
    )
  }
}
