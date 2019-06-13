import SwiftCheck
@testable import TennisKata

extension FortyData: Arbitrary {
    public static var arbitrary: Gen<FortyData> {
        return Gen.zip(Player.arbitrary, Point.arbitrary).map(FortyData.init)
    }
}
