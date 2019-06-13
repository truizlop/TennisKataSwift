struct PointData {
    let playerOnePoint: Point
    let playerTwoPoint: Point
    
    func point(forPlayer player: Player) -> Point {
        switch(player) {
        case .one: return playerOnePoint
        case .two: return playerTwoPoint
        }
    }
    
    func point(_ point: Point, toPlayer player: Player) -> PointData {
        switch(player) {
        case .one: return PointData(playerOnePoint: point, playerTwoPoint: playerTwoPoint)
        case .two: return PointData(playerOnePoint: playerOnePoint, playerTwoPoint: point)
        }
    }
}

extension PointData: CustomStringConvertible {
    var description: String {
        return "\(playerOnePoint) - \(playerTwoPoint)"
    }
}

extension PointData: Equatable {}
