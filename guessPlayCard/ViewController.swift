//
//  ViewController.swift
//  guessPlayCard
//
//  Created by Serhii on 23.02.18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardArr.count + 1) / 2)
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var labelCounter: UILabel!
    @IBOutlet var cardArr: [UIButton]!

    
    var counter = 0 {
        didSet {
            labelCounter.text = "Label Counter = \(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.startingNewGame()
        updateViewFromModel()
        counter = 0
    }

    @IBAction func cardButton(_ sender: UIButton) {
        //Кнопка нажалась, в кнопки береться індекс, і передається в метод ChoseCard, картка перевертається
        
        let myArrs = cardArr.index(of: sender)!
        game.chooseCard(at: myArrs)
        updateViewFromModel()
        counter += 1
        
        scoreLabel.text = "score = \(game.scoreFlipping(at: myArrs))"
    }
    
    func updateViewFromModel() {
        //Метод перевертає картку, і присвоюється емоджі
        
        for index in cardArr.indices {
            let button = cardArr[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9214877486, green: 0.9216203094, blue: 0.9214589, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        //Емоджі перемішуються
        if game.emoji[card.identifier] == nil {
            if game.changedEmoji.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(game.changedEmoji.count)))
                game.emoji[card.identifier] = game.changedEmoji.remove(at: randomIndex)
            }
        }

        return game.emoji[card.identifier] ?? "?"
    }
    
}

