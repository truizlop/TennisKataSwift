//
//  FortyDataExtensions.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import TennisKata

extension FortyData : Arbitrary {
    public static var arbitrary : Gen<FortyData> {
        return Gen<(Player, Point)>.zip(Player.arbitrary, Point.arbitrary).map(FortyData.init)
    }
}
