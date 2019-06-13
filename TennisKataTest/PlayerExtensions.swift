import SwiftCheck
@testable import TennisKata

extension Player: Arbitrary {
    public static var arbitrary: Gen<Player> {
        return Gen.fromElements(of: [Player.one, Player.two])
    }
}
