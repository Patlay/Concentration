//
//  Concetration.swift
//  Concetratuon
//
//  Created by Evgen Patlay on 11.06.18.
//  Copyright © 2018 Evgen Patlay. All rights reserved.
//

import Foundation

class Concetration
{
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var seenCards: Set<Int> = []
    private(set) var fliCount = 0

    private struct Points {
        static let matchBonus = 2
        static let missMatchPenalty = 1

    }

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundindex:  Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundindex == nil {
                        foundindex = index
                    } else {
                        return nil
                    }
                }

            }
            return foundindex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }

    }

    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched{
            fliCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifer == cards[index].identifer {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Points.matchBonus
                }else{
                    if seenCards.contains(index){
                        score -= Points.matchBonus
                    }
                    if seenCards.contains(matchIndex){
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true

            }else{
                // either no cards or 2 cards are faceUp
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }

    init(numbersOfPairsOfCards: Int) {
        assert(numbersOfPairsOfCards > 0, "Concentration.init(\(numbersOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numbersOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

}


extension Array {
    mutating func shuffle() {
        for index in self.indices {
           // let temp = self[index]
            let randonIndex = self.count.arc4random
            if randonIndex != index {
                self.swapAt(index, randonIndex)
            }

        }
    }
}









