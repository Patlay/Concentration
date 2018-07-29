//
//  ViewController.swift
//  Concetratuon
//
//  Created by Evgen Patlay on 10.06.18.
//  Copyright © 2018 Evgen Patlay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concetration(numbersOfPairsOfCards: numberOfPairsfCards)

    var numberOfPairsfCards: Int {
        return (cardButons.count + 1) / 2
    }



    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var newGameButton: UIButton!
    // @IBOutlet weak var titleLable: UILabel!

    @IBOutlet private weak var flipCountLabel: UILabel!

    @IBOutlet private var cardButons: [UIButton]!

    @IBAction private func newGameButtonTouch(_ sender: UIButton) {
        self.game = Concetration(numbersOfPairsOfCards: (cardButons.count + 1) / 2)





      //  emojiChoicees = ["👻", "🎃", "💀", "😈", "👽", "🤖","👺", "👓", "💼", "👒", "👗", "🐰"]
        indexTheme = keys.count.arc4random
        titleLabel.text = "\(keys[indexTheme])"
        updateViewFromModel()
    }

    @IBAction func touchCard(_ sender: UIButton) {

        if let cardNumber = cardButons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()

        } else {print("choosen card was not in cardButtons")}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = keys.count.arc4random
        updateViewFromModel()
        titleLabel.text = "\(keys[indexTheme])"

    }

    func updateViewFromModel() {
        for index in cardButons.indices{
            let button = cardButons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardBackColor
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.fliCount)"
    }
    typealias Theme = (emojiChoicees:[String], backgroundColor: UIColor, cardBackColor: UIColor)
    // 
    var emojiChoicees =  ["👻", "🎃", "💀", "😈", "👽", "🤖", "👺", "👓", "💼", "👒", "👗", "🐰"]
    private var emojiThemes: [String: Theme] = [
        "Halloween": (["👻", "🎃", "💀", "😈", "👺", "🦇", "🕷", "🕸", "🙀", "👽"], #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
        "Clothes": (["👠", "👗", "👕", "👒", "👟", "👔", "👖", "👓", "👞", "👚"], #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)),
        "Sport": (["⚽️", "🏓", "⛸", "🥊", "🏀", "🚴🏽‍♀️", "🏒", "🎾", "🏹", "🏸"], #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    ]
    private var keys: [String] {return Array(emojiThemes.keys)}
    private var backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private var cardBackColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    private var indexTheme = 1 {
        didSet {
            print(indexTheme, keys)
            (emojiChoicees, backgroundColor,cardBackColor) = emojiThemes[keys [indexTheme]] ?? ([], .black, .orange)
          //  titleLable.text = keys[indexTheme]
            emoji = [Int: String]()
            updateBackgroundColorCardBackColor()
        }
    }
    private func updateBackgroundColorCardBackColor() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        titleLabel.textColor = cardBackColor
        newGameButton.setTitleColor(cardBackColor, for:.normal)
        newGameButton.backgroundColor = backgroundColor
    }

   private var emoji = [Int: String]()


    private func emoji(for card: Card) -> String {
        if emoji[card.identifer] == nil, emojiChoicees.count > 0 {
           // let randomIndex = Int(arc4random_uniform(UInt32(emojiChoicees.count)))
            emoji[card.identifer] = emojiChoicees.remove(at: emojiChoicees.count.arc4random)
        }
        return emoji[card.identifer] ?? "?"
    }


    

}
extension Int {
    var arc4random: Int {
        if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
            
        }
}
}
