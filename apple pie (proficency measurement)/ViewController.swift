//
//  ViewController.swift
//  apple pie (proficency measurement)
//
//  Created by Joseph Lichtenstein on 10/15/19.
//  Copyright © 2019 Joseph Lichtenstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var CorrectWordLable: UILabel!
    @IBOutlet var scoreLable: UILabel!
    
    @IBOutlet var multiMode: UIButton!
    var listOfWords =  ["apple","orange-pop","banana","bus","planet","plant","bell","dock","air","water","fire","farmer","deal","jeopardy","wheel","fortune","cowboy","hangman","fruit","program","swift","bird","zebra","heinikein", "orca", "xylophone", "shining", "wheel-of-fortune", "apple-tree", "fire-fighter", "life-guard", "ranch-hand", "mr.yakubovsky", "united-states" ,"coppell-high-school", "jack-o-lanturn" ]
    
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
         didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    var multiwords = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()

    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0{
        totalLosses += 1
        } else if
            currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else{
            updateUI()
        }
    }
   @IBAction func multimodetoggle(_ sender: UIButton) {
        multiwords.toggle()
        if multiwords == false{
           multiMode.setTitle("multimode off", for: .normal)
        } else {
           multiMode.setTitle("multimode on", for: .normal)
        }
    }
 
    @IBAction func ButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()

    }
    
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty{
            
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            currentGame.guessedLetters.append("-")
            currentGame.guessedLetters.append(".")
            enableletterButtons(true)
            
        updateUI()

        }else{
            enableletterButtons(false)
        }
    }
    func enableletterButtons(_ enable: Bool ) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }

        let wordWithSpacing = letters.joined(separator: " ")
        CorrectWordLable.text = wordWithSpacing
        scoreLable.text = "Wins: \(totalWins), Losses: \(totalLosses), points"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
      
        if multiwords == false {
            if currentGame.word.contains("-") || currentGame.word.contains("."){
                newRound()
            }
        }

    }
}

