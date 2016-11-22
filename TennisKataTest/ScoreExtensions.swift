//
//  ScoreExtensions.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation
import SwiftCheck
@testable import TennisKata

extension Score : Arbitrary {
    public static var arbitrary : Gen<Score> {
        let pointGen = PointData.arbitrary.map{ return Score.points($0) }
        let fortyGen = FortyData.arbitrary.map{ return Score.forty($0) }
        let deuceGen = Gen<Score>.pure(Score.deuce)
        let advantageGen = Player.arbitrary.map{ return Score.advantage($0) }
        let gameGen = Player.arbitrary.map{ return Score.game($0) }
        return Gen<Score>.oneOf([pointGen, fortyGen, deuceGen, advantageGen, gameGen])
    }
}
