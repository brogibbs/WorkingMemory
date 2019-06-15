//
//  AnswersViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 5/29/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit
import CoreData

class AnswersViewController: UIViewController {
    
    var correctAnswers = [Int]()
    var userGuessTextFields = [UITextField]()
    var userGuesses = [String]()
    var correctLabels = [UILabel]()
    var correctGuesses: Int = 0
    let green = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.5)
    let red = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.6)
    @IBOutlet weak var checkAnswersButton: UIButton!
    @IBOutlet weak var backToNavButton: UIButton!
    
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
        for element in userGuessTextFields {
            userGuesses.append(element.text!)
        }
    }
    
    func updateCorrectLabels() {
        correctLabels.append(firstAnswer)
        correctLabels.append(secondAnswer)
        correctLabels.append(thirdAnswer)
        correctLabels.append(fourthAnswer)
        correctLabels.append(fifthAnswer)
        correctLabels.append(sixthAnswer)
        for index in 0..<correctLabels.count {
            correctLabels[index].text = String(correctAnswers[index])
        }
    }
    
    
    @IBAction func checkAnswers(_ sender: Any) {
        //checks users answers with correct answers
        updateTextFieldArray()
        getUserGuesses()
        updateCorrectLabels()
        for index in 0..<userGuesses.count {
            if userGuesses[index] == String(correctAnswers[index]) {
                userGuessTextFields[index].backgroundColor = green
                correctGuesses += 1
            } else {
                userGuessTextFields[index].backgroundColor = red
            }
            correctLabels[index].isHidden = false
        }
        checkAnswersButton.isEnabled = false

        //entity set up
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Trials", in: context)
        let newTrial = NSManagedObject(entity: entity!, insertInto: context)
        
        //set values for trial entitiy
        newTrial.setValue(correctGuesses, forKey: "correctGuesses")
        newTrial.setValue(correctAnswers.count, forKey: "level")
        newTrial.setValue(Date(), forKey: "userDate")
        
        //save entity data
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        //retrieve entity data
     /*   let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Trials")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "userDate") as! Date)
            }
            
        } catch {
            
            print("Failed")
        } */
    }
    @IBAction func backToNav(_ sender: UIButton) {
        performSegue(withIdentifier: "backToNavSegue", sender: self)
    }
    
}
