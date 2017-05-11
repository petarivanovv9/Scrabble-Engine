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
        end_index_is_valid = indexIsValid(coordinates.row, coordinates.col + letters_count - 1)
      case .Vertical:
        end_index_is_valid = indexIsValid(coordinates.row + letters_count - 1, coordinates.col)
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

  private func addWordCalcHelper(_ tiles: [Tile], _ start: Coordinate, _ direction: Direction) -> Int {
		var score = 0
		var ws_multipliers: [Int] = []
    for (indx, tile) in tiles.enumerated() {
			var curr_indx = start
      switch direction {
        case .Horizontal:
          curr_indx.col = curr_indx.col + indx
        case .Vertical:
          curr_indx.row = curr_indx.row + indx
      }

			var ls_multiplier = 1
			let curr_cell = self[curr_indx.row, curr_indx.col]
			if curr_cell.bonusType != nil {
				if curr_cell.bonusType! == "WS" {
					ws_multipliers.append(curr_cell.bonusMultiplier!)
				} else {
					ls_multiplier = curr_cell.bonusMultiplier!
				}
			}

      if self[curr_indx.row, curr_indx.col].hasTile() == false {
        self[curr_indx.row, curr_indx.col].setTile(tile: tile)
				score = score + tile.score * ls_multiplier
			}
			else if self[curr_indx.row, curr_indx.col].hasTile() == true
				&& self[curr_indx.row, curr_indx.col].tile!.letter == tile.letter {
				score = score + tile.score * ls_multiplier
			}
    }

		for i in ws_multipliers {
			score = score * i
		}
		return score
  }

  // returns the score of the word
  func addWord(tiles_word: [Tile], start_row_col: Coordinate, direction: Direction) -> Int {
		if self.isEmpty() && start_row_col != middle {
			print("The first word should start from the middle of the board!")
			return 0
		}
    if tryWord(tiles_word, start_row_col, direction) == false
      || wordCoordinatesAreValid(start_row_col, direction, tiles_word.count) == false {
      print("Can't write the word on the board!")
      return 0
    } else {
      // put the tiles on the board
			// calculate the score of the word
      return addWordCalcHelper(tiles_word, start_row_col, direction)
    }
  }

	func saveBoardToFile() {
		// "0 0 A 1"
		// TODO: при parse-ването на файла трябва да проверя дали е буква или бонус
		// TODO: и съответно да знам дали да променя клетката или да добавя плочка в/у нея
		let new_saved_game_file = FileManager.default.currentDirectoryPath + "/Sources/new_saved_game.txt"

		Parser.writeToFile(content: "--BOARD--", filePath: new_saved_game_file)
		Parser.writeToFile(content: "\(nrows) \(ncolumns)", filePath: new_saved_game_file)

		for i in 0..<nrows {
			for j in 0..<ncolumns {
				var line = ""
				if self[i, j].hasBonus() == true && self[i, j].hasTile() == true {
					line += "\(i) \(j) \(self[i, j].bonusType!) \(self[i, j].bonusMultiplier!)"
					line += "\n"
					line += "\(i) \(j) \(self[i, j].tile!.letter) \(self[i, j].tile!.score)"
				}
				else if self[i, j].hasBonus() == true && self[i, j].hasTile() == false {
					line += "\(i) \(j) \(self[i, j].bonusType!) \(self[i, j].bonusMultiplier!)"
				}
				else if self[i, j].hasBonus() == false && self[i, j].hasTile() == true {
					line += "\(i) \(j) \(self[i, j].tile!.letter) \(self[i, j].tile!.score)"
				}
				if line != "" {
					Parser.writeToFile(content: line, filePath: new_saved_game_file)
				}
			}
		}
	}
}

extension Board: CustomStringConvertible {

  var description: String {
    return cells.map { row in row.map { $0.description }.joined(separator: " | ") }
        .joined(separator: "\n\n") + "\n\n"
  }
}
