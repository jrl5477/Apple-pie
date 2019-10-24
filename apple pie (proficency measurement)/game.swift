//
//  game.swift
//  apple pie (proficency measurement)
//
//  Created by Joseph Lichtenstein on 10/17/19.
//  Copyright © 2019 Joseph Lichtenstein. All rights reserved.
//

import Foundation

struct Game {
    
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }

    }

    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            
             // hold off
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
                

            }
        }
        return guessedWord
    }
}

