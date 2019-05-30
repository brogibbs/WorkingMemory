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

    @IBOutlet weak var firstGuess: UITextField!
    @IBOutlet weak var secondGuess: UITextField!
    @IBOutlet weak var thirdGuess: UITextField!
    @IBOutlet weak var fourthGuess: UITextField!
    @IBOutlet weak var fifthGuess: UITextField!
    @IBOutlet weak var sixthGuess: UITextField!
    
    @IBAction func checkAnswers(_ sender: Any) {
        firstCheck()
        secondCheck()
        thirdCheck()
        fourthCheck()
        fifthCheck()
        sixthCheck()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
  func firstCheck() {
        if(firstGuess.text == String(correctAnswers[0])) {
            firstGuess.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
        } else {
            firstGuess.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
        }
    }
    
    func secondCheck() {
        if(secondGuess.text == String(correctAnswers[1])) {
            secondGuess.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
        } else {
            secondGuess.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
        }
    }
    
    func thirdCheck() {
        if(thirdGuess.text == String(correctAnswers[2])) {
            thirdGuess.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
        } else {
            thirdGuess.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
        }
    }
    
    func fourthCheck() {
        if(fourthGuess.text == String(correctAnswers[3])) {
            fourthGuess.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
        } else {
            fourthGuess.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
        }
    }
    
    func fifthCheck() {
        if(fifthGuess.text == String(correctAnswers[4])) {
            fifthGuess.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
        } else {
            fifthGuess.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
        }
    }
    
    func sixthCheck() {
        if(sixthGuess.text == String(correctAnswers[5])) {
            sixthGuess.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
        } else {
            sixthGuess.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
        }
    }
    



}
