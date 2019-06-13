let newGame = Score.points(PointData(playerOnePoint: .love, playerTwoPoint: .love))

func scoreSequence(wins: Player...) -> Score {
    return scoreSequence(wins: wins)
}

func scoreSequence(wins: [Player]) -> Score {
    return wins.reduce(newGame, score)
}

func score(current: Score, winner: Player) -> Score {
    switch current {
    case let .points(pointData): return scoreWhenPoints(winner: winner, current: pointData)
    case let .forty(fortyData): return scoreWhenForty(winner: winner, current: fortyData)
    case .deuce: return scoreWhenDeuce(winner: winner)
    case let .advantage(player): return scoreWhenAdvantage(advantagedPlayer: player, winner: winner)
    case .game: return scoreWhenGame(winner: winner)
    }
}

func scoreWhenGame(winner: Player) -> Score {
    return .game(winner)
}

func scoreWhenAdvantage(advantagedPlayer: Player, winner: Player) -> Score {
    if advantagedPlayer == winner {
        return .game(winner)
    } else {
        return .deuce
    }
}

func scoreWhenDeuce(winner: Player) -> Score {
    return .advantage(winner)
}

func scoreWhenForty(winner: Player, current: FortyData) -> Score {
    if winner == current.player {
        return .game(winner)
    } else {
        if let newPoint = current.otherPlayerPoint.increment {
            return .forty(FortyData(player: current.player, otherPlayerPoint: newPoint))
        } else {
            return .deuce
        }
    }
}

func scoreWhenPoints(winner: Player, current: PointData) -> Score {
    if let newPoint = current.point(forPlayer: winner).increment {
        return .points(current.point(newPoint, toPlayer: winner))
    } else {
        return .forty(FortyData(player: winner, otherPlayerPoint: current.point(forPlayer: winner.other)))
    }
}
