//
//  HangmanPhrases.swift
//  Hangman
//
import Foundation

class HangmanPhrases {
    
    var phrases : NSArray!
    
    // Inicjacja fraz za pomoca wszystkich dostepnych z tablicy.
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
    }
    
    // Losowanie losowej frazy z dostepnych.
    func getRandomPhrase() -> String {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        return phrases.object(at: index) as! String
    }
    
    var answer = ""
    var validLetters = Set<Character>()
    var incorrectGuesses = [Character]()
    var correctGuesses = [Character]()
    
    func initAnswerAndValidLetters() {
        answer = getRandomPhrase()
        validLetters = Set<Character>()
        for c in answer{
            if !(c == " ") && !validLetters.contains(c) {
                validLetters.insert(c)
            }
        }
    }
    
    func checkGuess(_ c: Character) {
        if answer.contains(String(c)) {
            validLetters.remove(c)
            correctGuesses.append(c)
        } else {
            incorrectGuesses.append(c)
        }
        
    }
    
    func checkLoss() -> Bool {
        if incorrectGuesses.count >= 6 {
            return true
        }
        return false
    }
    
    func checkWin() -> Bool {
        print(validLetters.count)
        print(validLetters.first ?? "puste")
        if validLetters.isEmpty {
            
            return true
        }
        return false
    }
    
    func displayedProgress() -> String {
        var displayed = ""
        for c in answer{
            if c == " " {
                displayed += "  "
            } else if correctGuesses.contains(c) {
                displayed += String(c) + " "
            } else {
                displayed += "_ "
            }
        }
        return displayed
    }
    
    
    
}
