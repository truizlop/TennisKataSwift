//
//  TennisTest.swift
//  TennisKata
//
//  Created by Tomás Ruiz López on 22/11/16.
//  Copyright © 2016 Tomás Ruiz-López. All rights reserved.
//

import XCTest
import SwiftCheck
@testable import TennisKata

class TennisTest: XCTestCase {

    func testScoring() {
        property("Given a game is over it stays over") <- forAll{ (player : Player) in
            let actual = scoreWhenGame(winner: player)
            let expected = Score.game(player)
            return actual == expected
        }
        
        property("Given advantage, when advantaged player scores, the game is over in its favor") <- forAll {
            (player : Player) in
            let actual = scoreWhenAdvantage(advantagedPlayer: player, winner: player)
            let expected = Score.game(player)
            return actual == expected
        }
        
        property("Given advantage, when the other player scores, the result is deuce") <- forAll {
            (player : Player) in
            let actual = scoreWhenAdvantage(advantagedPlayer: player, winner: player.other)
            let expected = Score.deuce
            return actual == expected
        }
        
        property("Given deuce, when a player scores, it gets advantaged") <- forAll {
            (player : Player) in
            let actual = scoreWhenDeuce(winner: player)
            let expected = Score.advantage(player)
            return actual == expected
        }
        
        property("Given a player with 40 points, when it scores, the game is over") <- forAll {
            (current : FortyData) in
            let actual = scoreWhenForty(winner: current.player, current: current)
            let expected = Score.game(current.player)
            return actual == expected
        }
        
        property("Given a result 40 - 30, when the latter player scores, the result is deuce") <- forAll {
            (player : Player) in
            let current = FortyData(player: player, otherPlayerPoint: Point.thirty)
            let actual = scoreWhenForty(winner: player.other, current: current)
            return actual == Score.deuce
        }
        
        let lessThan30Gen = Gen<Point>.fromElements(of: [Point.love, Point.fifteen])
        property("Given a result 40 - < 30, when the latter player scores, its points are incremented") <- forAll {
            (player : Player) in
            return forAll(lessThan30Gen.map{FortyData(player : player, otherPlayerPoint: $0)}){
                (current : FortyData) in
                let actual = scoreWhenForty(winner: current.player.other, current: current)
                let expected = Score.forty(FortyData(player: current.player, otherPlayerPoint: current.otherPlayerPoint.increment!))
                return actual == expected
            }
        }
        
        property("Given a player has 30 points, when it scores, it gets 40") <- forAll {
            (pointData : PointData, player : Player) in
            let current = pointData.point(.thirty, toPlayer: player)
            let actual = scoreWhenPoints(winner: player, current: current)
            let expected = Score.forty(FortyData(player: player, otherPlayerPoint: current.point(forPlayer: player.other)))
            return actual == expected
        }
        
        let pointDataGen = Gen<(Point, Point)>.zip(lessThan30Gen, lessThan30Gen).map(PointData.init)
        property("Given both players have <30 points, when one scores, its points are incremented") <- forAll(Player.arbitrary, pointDataGen) {
            (player : Player, current : PointData) in
            let actual = scoreWhenPoints(winner: player, current: current)
            let expectedPlayerPoint = current.point(forPlayer: player).increment!
            let expected = Score.points(current.point(expectedPlayerPoint, toPlayer: player))
            return actual == expected
        }
        
        property("Score always returns a value") <- forAll {
            (current : Score, player : Player) in
            let actual = score(current: current, winner: player)
            print(actual)
            return true
        }
    }

    func testTennisRules() {
        property("A game with less than 4 balls isn't over") <- forAll(self.generateSequenceOf(lengthSmallerThan: 4)) {
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return !self.isGame(actual)
        }
        
        property("A game with less than 6 balls can't be deuce") <- forAll(self.generateSequenceOf(lengthSmallerThan: 6)) {
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return !self.isDeuce(actual)
        }
        
        property("A game with less than 7 balls can't have any player with advantage") <- forAll(self.generateSequenceOf(lengthSmallerThan: 7)) {
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return !self.isAdvantage(actual)
        }
        
        property("A game with more than 4 balls can't be points") <- forAll(self.generateSequenceOf(lengthGreaterThan: 4)) {
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return !self.isPoints(actual)
        }
        
        property("A game with more than 5 balls can't be forty") <- forAll(self.generateSequenceOf(lengthGreaterThan: 5)) {
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return !self.isForty(actual)
        }
        
        property("A game where one player wins all balls is over in 4 balls") <- forAll(self.generateSequenceOfSamePlayer(withLength: 4)) {
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return self.isGame(actual)
        }
        
        property("A game where players alternate winning balls is never over") <- forAll(self.generateSequenceOfAlternatingPlayers()){
            (sequence : [Player]) in
            let actual = scoreSequence(wins: sequence)
            return !self.isGame(actual)
        }
    }
    
    func generateSequenceOf(lengthSmallerThan n : Int) -> Gen<[Player]> {
        return Array<Player>.arbitrary.suchThat{ $0.count < n }
    }
    
    func generateSequenceOf(lengthGreaterThan n : Int) -> Gen<[Player]> {
        return Array<Player>.arbitrary.suchThat{ $0.count > n }
    }
    
    func generateSequenceOfSamePlayer(withLength n : Int) -> Gen<[Player]> {
        return Player.arbitrary.map{ Array(repeating: $0, count:n) }
    }
    
    func generateSequenceOfAlternatingPlayers() -> Gen<[Player]> {
        let positiveGen = Int.arbitrary.suchThat{ $0 > 0 }
        return Gen<(Int, Player)>.zip(positiveGen, Player.arbitrary)
            .map{ Array(repeating: $1, count: $0).flatMap{ [$0, $0.other] } }
    }
    
    func isPoints(_ score : Score) -> Bool {
        switch(score) {
        case .points(_) : return true
        default : return false
        }
    }
    
    func isForty(_ score : Score) -> Bool {
        switch(score) {
        case .forty(_) : return true
        default : return false
        }
    }
    
    func isDeuce(_ score : Score) -> Bool {
        switch(score) {
        case .deuce : return true
        default : return false
        }
    }
    
    func isAdvantage(_ score : Score) -> Bool {
        switch(score) {
        case .advantage(_) : return true
        default : return false
        }
    }
    
    func isGame(_ score : Score) -> Bool {
        switch(score) {
        case .game(_) : return true
        default : return false
        }
    }
}
