//
//  Card.swift
//  Concetratuon
//
//  Created by Evgen Patlay on 11.06.18.
//  Copyright © 2018 Evgen Patlay. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifer: Int

    private static var identiferFactory = 0

    private static func getUniqueIdentifer() -> Int{
        identiferFactory += 1
        return identiferFactory
    }
    init() {
        self.identifer = Card.getUniqueIdentifer()
    }
}
