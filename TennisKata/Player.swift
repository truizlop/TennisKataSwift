enum Player: String {
    case one = "Player one", two = "Player two"
    
    var other: Player {
        switch(self) {
        case .one: return .two
        case .two: return .one
        }
    }
}

extension Player: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}
