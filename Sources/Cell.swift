import Foundation

class Cell {
  var bonusType: String?
  var bonusMultiplier: Int?
  var tile: Tile?

  init() {
    bonusType = nil
    bonusMultiplier = nil
    tile = nil
  }

  init(bonusType: String, bonusMultiplier: Int) {
    self.bonusType = bonusType
    self.bonusMultiplier = bonusMultiplier
  }

  func hasBonus() -> Bool {
    return bonusType != ""
  }

  func setTile(tile: Tile) {
    self.tile = tile
  }

  func hasTile() -> Bool {
    return tile != nil
  }
}

extension Cell: CustomStringConvertible {

  var description: String {
    return "\(bonusType)-\(bonusMultiplier)-\(tile)"
  }
}
