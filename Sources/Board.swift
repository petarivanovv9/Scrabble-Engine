import Foundation


class Board {
  let rows: Int
  let columns: Int
  let middle: Coordinate
  var cells: [[Cell]] = []

  typealias Coordinate = (row: Int, col: Int)

  init(dims: (Int, Int)) {
    self.rows = dims.0
    self.columns = dims.1
    self.middle = (row: self.rows / 2, col: self.columns / 2)
    self.cells = Array(
      repeating: Array(repeating: Cell(), count: self.columns),
      count: self.rows
    )
  }

  convenience init?(dim: Int) {
    self.init(dims: (dim, dim))
  }

  private func indexIsValid(_ row: Int, _ column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }

  private func wordCoordinatesAreValid(_ coordinates: Coordinate, _ direction: Character, _ letters_count: Int) -> Bool {
    let start_index_is_valid = indexIsValid(coordinates.row, coordinates.col)
    var end_index_is_valid: Bool

    switch direction {
    case "H":
      end_index_is_valid = indexIsValid(coordinates.row, coordinates.col + letters_count)
    case "V":
      end_index_is_valid = indexIsValid(coordinates.row + letters_count, coordinates.col)
    default:
      end_index_is_valid = false
    }

    return start_index_is_valid && end_index_is_valid
  }

  // subscript(coordinate: Coordinate) -> Cell {
  subscript(row: Int, col: Int) -> Cell {
    get {
      // assert(indexIsValid(row: coordinate.row, column: coordinate.col), "Index out of range")
      assert(indexIsValid(row, col), "Index out of range")
      return self.cells[row][col]
    }
    set {
      // assert(indexIsValid(row: coordinate.row, column: coordinate.col), "Index out of range")
      assert(indexIsValid(row, col), "Index out of range")
      self.cells[row][col] = newValue
    }
  }

  // checks is it possible to write a word on the board
  private func tryWord(_ tiles_word: [Tile], _ start_row_col: Coordinate, _ direction: Character) -> Bool {
    return true
  }

  // check the center cell of the board
  func isEmpty() -> Bool {
    return self.cells[middle.row][middle.col].hasTile() == false
  }

  // returns the score of the word
  func addWord(tiles_word: [Tile], start_row_col: Coordinate, direction: Character) -> Int {
    if tryWord(tiles_word, start_row_col, direction) == false {
      print("Can't write the word on the board!")
      return 0
    } else {
      // put the tiles on the board
      // calculate the score of the word
      return 0
    }
  }
}

extension Board: CustomStringConvertible {

  var description: String {
    return self.cells.map { row in row.map { $0.description }.joined(separator: " | ") }
        .joined(separator: "\n") + "\n"
  }
}


// var board = Board(dims: (7, 7))
// for i in 0..<board.cells.count {
//   for j in 0..<board.cells[i].count {
//     print(board.cells[i][j])
//   }
// }
