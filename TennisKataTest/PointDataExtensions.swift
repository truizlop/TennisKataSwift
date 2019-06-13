import SwiftCheck
@testable import TennisKata

extension PointData: Arbitrary {
    public static var arbitrary: Gen<PointData> {
        return Gen.zip(Point.arbitrary, Point.arbitrary).map(PointData.init)
    }
}
