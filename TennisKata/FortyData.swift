struct FortyData {
    let player: Player
    let otherPlayerPoint: Point
}

extension FortyData: CustomStringConvertible {
    var description: String {
        switch player {
        case .one: return "40 - \(otherPlayerPoint)"
        case .two: return "\(otherPlayerPoint) - 40"
        }
    }
}

extension FortyData: Equatable {}
