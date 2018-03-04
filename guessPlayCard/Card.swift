//
//  Card.swift
//  guessPlayCard
//
//  Created by Serhii on 24.02.18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp  = false
    var isMatched = false
    var wasFliped = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
