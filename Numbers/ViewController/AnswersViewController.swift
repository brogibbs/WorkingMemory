//
//  AnswersViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 5/29/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    var correctAnswers = [Int]()
    var userGuessTextFields = [UITextField]()
    var userGuesses = [String]()
    var correctLabels = [UILabel]()

    //user guesses
    @IBOutlet weak var firstGuess: UITextField!
    @IBOutlet weak var secondGuess: UITextField!
    @IBOutlet weak var thirdGuess: UITextField!
    @IBOutlet weak var fourthGuess: UITextField!
    @IBOutlet weak var fifthGuess: UITextField!
    @IBOutlet weak var sixthGuess: UITextField!
    
    //correct answers
    @IBOutlet weak var firstAnswer: UILabel!
    @IBOutlet weak var secondAnswer: UILabel!
    @IBOutlet weak var thirdAnswer: UILabel!
    @IBOutlet weak var fourthAnswer: UILabel!
    @IBOutlet weak var fifthAnswer: UILabel!
    @IBOutlet weak var sixthAnswer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func updateTextFieldArray() {
        userGuessTextFields.append(firstGuess)
        userGuessTextFields.append(secondGuess)
        userGuessTextFields.append(thirdGuess)
        userGuessTextFields.append(fourthGuess)
        userGuessTextFields.append(fifthGuess)
        userGuessTextFields.append(sixthGuess)
    }
    
    func getUserGuesses() {
        userGuesses.append(firstGuess.text!)
        userGuesses.append(secondGuess.text!)
        userGuesses.append(thirdGuess.text!)
        userGuesses.append(fourthGuess.text!)
        userGuesses.append(fifthGuess.text!)
        userGuesses.append(sixthGuess.text!)
    }
    
    func updateCorrectLabels() {
        correctLabels.append(firstAnswer)
        correctLabels.append(secondAnswer)
        correctLabels.append(thirdAnswer)
        correctLabels.append(fourthAnswer)
        correctLabels.append(fifthAnswer)
        correctLabels.append(sixthAnswer)
        for index in 0..<6 {
            correctLabels[index].text = String(correctAnswers[index])
        }
    }
    
    
    @IBAction func checkAnswers(_ sender: Any) {
        //checks users answers with correct answers
        updateTextFieldArray()
        getUserGuesses()
        updateCorrectLabels()
        for index in 0..<6 {
            if userGuesses[index] == String(correctAnswers[index]) {
                userGuessTextFields[index].backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
            } else {
                userGuessTextFields[index].backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
            }
            correctLabels[index].isHidden = false
        }
    }

}
