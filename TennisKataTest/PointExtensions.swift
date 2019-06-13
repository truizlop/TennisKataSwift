//
//  PointExtensions.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import TennisKata

extension Point : Arbitrary {
    public static var arbitrary : Gen<Point> {
        return Gen<Point>.fromElements(of: [Point.love, Point.fifteen, Point.thirty])
    }
}
