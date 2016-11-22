//
//  FortyData.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation

struct FortyData {
    let player : Player
    let otherPlayerPoint : Point
}

extension FortyData : CustomStringConvertible {
    var description : String {
        switch player {
        case .one: return "40 - \(otherPlayerPoint)"
        case .two: return "\(otherPlayerPoint) - 40"
        }
    }
}

extension FortyData : Equatable {}

func ==(lhs : FortyData, rhs : FortyData) -> Bool {
    return lhs.player == rhs.player &&
            lhs.otherPlayerPoint == rhs.otherPlayerPoint
}
