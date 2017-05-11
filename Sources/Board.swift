import Foundation

enum Direction {
	case Horizontal
	case Vertical
}

class Board {
  let nrows: Int
  let ncolumns: Int
  let middle: Coordinate
  var cells: [[Cell]]

  typealias Coordinate = (row: Int, col: Int)

  init(dims: (Int, Int)) {
    nrows = dims.0
    ncolumns = dims.1
    middle = (row: nrows / 2, col: ncolumns / 2)
		cells = []
		for _ in 0..<nrows {
			var row : [Cell] = []
			for _ in 0..<ncolumns {
				row.append(Cell())
			}
			cells.append(row)
		}
  }

  convenience init?(dim: Int) {
    self.init(dims: (dim, dim))
  }

  private func indexIsValid(_ row: Int, _ col: Int) -> Bool {
    return row >= 0 && row < nrows && col >= 0 && col < ncolumns
  }

  private func wordCoordinatesAreValid(_ coordinates: Coordinate, _ direction: Direction, _ letters_count: Int) -> Bool {
    let start_index_is_valid = indexIsValid(coordinates.row, coordinates.col)
    var end_index_is_valid: Bool

    switch direction {
      case .Horizontal:
        end_index_is_valid = indexIsValid(coordinates.row, coordinates.col + letters_count)
      case .Vertical:
        end_index_is_valid = indexIsValid(coordinates.row + letters_count, coordinates.col)
    }

    return start_index_is_valid && end_index_is_valid
  }

  // subscript(coordinate: Coordinate) -> Cell {
  subscript(row: Int, col: Int) -> Cell {
    get {
      // assert(indexIsValid(row: coordinate.row, column: coordinate.col), "Index out of range")
      assert(indexIsValid(row, col), "Index out of range")
      return cells[row][col]
    }
    set {
      // assert(indexIsValid(row: coordinate.row, column: coordinate.col), "Index out of range")
      assert(indexIsValid(row, col), "Index out of range")
			cells[row][col] = newValue
    }
  }

  // checks is it possible to write a word on the board
  private func tryWord(_ tiles_word: [Tile], _ start_row_col: Coordinate, _ direction: Direction) -> Bool {
    return true
  }

  // check the center cell of the board
  func isEmpty() -> Bool {
    return cells[middle.row][middle.col].hasTile() == false
  }

  private func addWordHelper(_ tiles: [Tile], _ start: Coordinate, _ direction: Direction) {

    for (indx, tile) in tiles.enumerated() {
      // var bonus_multiplier = 1
      // if curr_cell.bonusType != nil {
      //   bonus_multiplier = curr_cell.bonusType!
      // }
      var curr_indx = start

      switch direction {
        case .Horizontal:
          curr_indx.col = curr_indx.col + indx
        case .Vertical:
          curr_indx.row = curr_indx.row + indx
      }

      if self[curr_indx.row, curr_indx.col].hasTile() == false {
        self[curr_indx.row, curr_indx.col].setTile(tile: tile)
			}
    }
  }

  // returns the score of the word
  func addWord(tiles_word: [Tile], start_row_col: Coordinate, direction: Direction) -> Int {
    if tryWord(tiles_word, start_row_col, direction) == false
      || wordCoordinatesAreValid(start_row_col, direction, tiles_word.count) == false {
      print("Can't write the word on the board!")
      return 0
    } else {
      // put the tiles on the board
      addWordHelper(tiles_word, start_row_col, direction)
      // calculate the score of the word
      return 0
    }
  }
}

extension Board: CustomStringConvertible {

  var description: String {
    return cells.map { row in row.map { $0.description }.joined(separator: " | ") }
        .joined(separator: "\n\n") + "\n\n"
  }
}
