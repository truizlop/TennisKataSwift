enum Point: String {
    case love = "Love", fifteen = "15", thirty = "30"
    
    var increment: Point? {
        switch(self) {
        case .love: return .fifteen
        case .fifteen: return .thirty
        case .thirty: return nil
        }
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}
