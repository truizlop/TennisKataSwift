//
//  Player.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import Foundation

enum Player : String {
    case one = "Player one", two = "Player two"
    
    var other : Player {
        switch(self) {
        case .one: return .two
        case .two: return .one
        }
    }
}

extension Player : CustomStringConvertible {
    var description : String {
        return rawValue
    }
}
