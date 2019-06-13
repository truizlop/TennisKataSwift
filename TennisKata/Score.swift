enum Score {
    case points(PointData)
    case forty(FortyData)
    case deuce
    case advantage(Player)
    case game(Player)
}

extension Score: CustomStringConvertible {
    var description: String {
        switch(self) {
        case let .points(pointData): return pointData.description
        case let .forty(fortyData): return fortyData.description
        case .deuce: return "Deuce"
        case let .advantage(player): return "Advantage for \(player)"
        case let .game(player): return "Game for \(player)"
        }
    }
}

extension Score: Equatable {}
