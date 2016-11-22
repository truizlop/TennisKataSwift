//
//  PointData.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation

struct PointData {
    let playerOnePoint : Point
    let playerTwoPoint : Point
    
    func point(forPlayer player : Player) -> Point {
        switch(player) {
        case .one: return playerOnePoint
        case .two: return playerTwoPoint
        }
    }
    
    func point(_ point : Point, toPlayer player : Player) -> PointData {
        switch(player) {
        case .one: return PointData(playerOnePoint: point, playerTwoPoint: playerTwoPoint)
        case .two: return PointData(playerOnePoint: playerOnePoint, playerTwoPoint: point)
        }
    }
}

extension PointData : CustomStringConvertible {
    var description : String {
        return "\(playerOnePoint) - \(playerTwoPoint)"
    }
}

extension PointData : Equatable {}

func ==(lhs : PointData, rhs : PointData) -> Bool {
    return lhs.playerOnePoint == rhs.playerOnePoint &&
            lhs.playerTwoPoint == rhs.playerTwoPoint
}
