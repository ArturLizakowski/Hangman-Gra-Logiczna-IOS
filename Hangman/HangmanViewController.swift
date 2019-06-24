//
//  GameViewController.swift
//  Hangman
//

import UIKit

class HangmanViewController: UIViewController {

    var hangmanPhrases = HangmanPhrases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generacja randomowych fraz.
        
        hangmanPhrases.initAnswerAndValidLetters()
        updateDisplayedGuesses()
        print(hangmanPhrases.answer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var hangmanImage: UIImageView!
    func updateHangmanImage() {
        let numWrong = hangmanPhrases.incorrectGuesses.count
        if numWrong == 0 {
            hangmanImage.image = UIImage(named: "hangman1")
        } else if (numWrong <= 6){
            let imgName: String = "hangman" + String(numWrong + 1)
            hangmanImage.image = UIImage(named: imgName)
        }
    }
    
    
    @IBOutlet weak var incorrectLetters: UILabel!
    func updateIncorrectLetters() {
        var incorrectList = ""
        for c in hangmanPhrases.incorrectGuesses {
            incorrectList += String(c) + ", "
        }
        self.incorrectLetters.text = incorrectList
    }
    
    
    @IBOutlet weak var guessedLetter: UITextField!
    
    
    @IBOutlet weak var displayedGuesses: UILabel!
    func updateDisplayedGuesses() {
        displayedGuesses.text = hangmanPhrases.displayedProgress()
    }
    
    
    @IBAction func madeGuess(_ sender: UIButton) {
        var userGuess:String = guessedLetter.text ?? ""
        guessedLetter.text = ""
        if userGuess.count > 1 {
            return
        }
        userGuess = userGuess.capitalized
        let checkLetter: Character = userGuess.first ?? " "
        hangmanPhrases.checkGuess(checkLetter)
        updateIncorrectLetters()
        updateDisplayedGuesses()
        updateHangmanImage()
        if hangmanPhrases.checkWin() {
            endGame(msg: "Bystrzak!")
        }
        print("przejdz tam")
        if hangmanPhrases.checkLoss() {
            endGame(msg: "Skucha!")
        }
        
    }
    
    func endGame(msg: String){
        let alertController = UIAlertController(title: msg, message:
            nil, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Sprobuj ponownie!", style: UIAlertAction.Style.default,handler: resetGame))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func resetGame(alert: UIAlertAction!){
        print("Restart.")
        
        hangmanPhrases = HangmanPhrases()
        hangmanPhrases.initAnswerAndValidLetters()
        
        updateIncorrectLetters()
        updateDisplayedGuesses()
        updateHangmanImage()
    }
    
    
    
    
    
    
}
