//
//  Score.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation

enum Score {
    case points(_ : PointData)
    case forty(_ : FortyData)
    case deuce
    case advantage(_ : Player)
    case game(_ : Player)
}

extension Score : CustomStringConvertible {
    var description : String {
        switch(self) {
        case let .points(pointData): return pointData.description
        case let .forty(fortyData): return fortyData.description
        case .deuce: return "Deuce"
        case let .advantage(player): return "Advantage for \(player)"
        case let .game(player): return "Game for \(player)"
        }
    }
}
