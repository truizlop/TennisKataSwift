import XCTest
import SwiftCheck
@testable import TennisKata

class PlayerTest: XCTestCase {
    
    func testOtherPlayer() {
        property("other returns a different player") <- forAll{ (player: Player) in
            return player.other != player
        }
        
        property("other other player returns the same player") <- forAll{ (player: Player) in
            return player.other.other == player
        }
    }
    
}
