//
//  PlayerExtensions.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import SwiftCheck
@testable import TennisKata

extension Player : Arbitrary {
    public static var arbitrary : Gen<Player> {
        return Gen<Player>.fromElementsOf([Player.one, Player.two])
    }
}
