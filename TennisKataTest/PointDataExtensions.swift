//
//  PointDataExtensions.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import TennisKata

extension PointData : Arbitrary {
    public static var arbitrary : Gen<PointData> {
        return Gen<(Point, Point)>.zip(Point.arbitrary, Point.arbitrary).map(PointData.init)
    }
}
