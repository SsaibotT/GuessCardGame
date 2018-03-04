//
//  Concentration.swift
//  guessPlayCard
//
//  Created by Serhii on 24.02.18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    
    func chooseCard(at index: Int) {
        // Метод виставляє параметри чи вони збіглись і чи вони лицем догори
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                //піднімається перша, провіряє всі 12 карт чи вони підняті
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    let animalThemeEmoji = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
    let sportThemeEmoji  = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"]
    let smilesThemeEmoji = ["😀", "👹", "😇", "😎", "🤡", "🤠", "💩", "😈"]
    let foodThemeEmoji   = ["🍏", "🍌", "🍉", "🍑", "🌽", "🍔", "🍭", "🍕"]
    let flagsThemeEmoji  = ["🇵🇱", "🇷🇴", "🇸🇰", "🇺🇦", "🇨🇿", "🇯🇵", "🇼🇸", "🇰🇷"]
    let travelThemeEmoji = ["🚗", "🚜", "🛳", "🚃", "🚄", "✈️", "🚁", "🚀"]
    
    lazy var changedEmoji = animalThemeEmoji
    var emoji = [Int:String]()
    
    func addNewTheme () {
    // Метод обновляє рандомну тему для початку гри
        var arrayOfThemesEmoji = [animalThemeEmoji, sportThemeEmoji, smilesThemeEmoji, foodThemeEmoji, flagsThemeEmoji, travelThemeEmoji]
        
        let randIndexForChoosingArray = Int(arc4random_uniform(UInt32(arrayOfThemesEmoji.count)))
        emoji.removeAll()
        changedEmoji = arrayOfThemesEmoji[randIndexForChoosingArray]
    }

    func startingNewGame() {
        //Метод виставляє умови для нової гри
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].wasFliped = false
        }
        score = 0
        shuffledCards()
        addNewTheme()
    }
    
    func scoreFlipping (at index: Int) -> Int {
        if cards[index].isMatched{
            if cards[index].wasFliped {
                score += 3
                return score
            } else {
                score += 2
                return score
            }
        }
        if cards[index].wasFliped == false {
            if cards[index].isFaceUp == true {
                cards[index].wasFliped = true
            }
        } else {
            score += -1
            return score
        }
        return score
    }
    
    func shuffledCards() {
        //Метод перемішування карт
        var shuffled = [Card]()
        for _ in cards.indices {
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards[rand])
            cards.remove(at: rand)
        }
        
        cards = shuffled
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffledCards()
    }
}
