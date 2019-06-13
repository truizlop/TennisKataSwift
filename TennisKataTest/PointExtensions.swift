import SwiftCheck
@testable import TennisKata

extension Point: Arbitrary {
    public static var arbitrary: Gen<Point> {
        return Gen.fromElements(of: [Point.love, Point.fifteen, Point.thirty])
    }
}
