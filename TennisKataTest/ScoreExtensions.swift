import SwiftCheck
@testable import TennisKata

extension Score: Arbitrary {
    public static var arbitrary: Gen<Score> {
        let pointGen = PointData.arbitrary.map(Score.points)
        let fortyGen = FortyData.arbitrary.map(Score.forty)
        let deuceGen = Gen<Score>.pure(Score.deuce)
        let advantageGen = Player.arbitrary.map(Score.advantage)
        let gameGen = Player.arbitrary.map(Score.game)
        return Gen.one(of: [pointGen, fortyGen, deuceGen, advantageGen, gameGen])
    }
}
