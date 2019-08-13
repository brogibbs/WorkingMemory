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
    var count = 0

    @IBOutlet weak var checkAnswersButton: UIButton!
    @IBOutlet weak var checkAnswersLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitLabel: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    //user guesse
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
    
    @IBOutlet weak var correct1: UILabel!
    @IBOutlet weak var correct2: UILabel!
    @IBOutlet weak var correct3: UILabel!
    @IBOutlet weak var correct4: UILabel!
    @IBOutlet weak var correct5: UILabel!
    @IBOutlet weak var correct6: UILabel!
    var correctAnswerArray = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAnswerArray()
        firstGuess.becomeFirstResponder()
        firstGuess.borderStyle = UITextField.BorderStyle.roundedRect
        secondGuess.borderStyle = UITextField.BorderStyle.roundedRect
        thirdGuess.borderStyle = UITextField.BorderStyle.roundedRect
        fourthGuess.borderStyle = UITextField.BorderStyle.roundedRect
        fifthGuess.borderStyle = UITextField.BorderStyle.roundedRect
        sixthGuess.borderStyle = UITextField.BorderStyle.roundedRect
        // Do any additional setup after loading the view.
    }
    
    func createAnswerArray() {
        correctAnswerArray.append(correct1)
        correctAnswerArray.append(correct2)
        correctAnswerArray.append(correct3)
        correctAnswerArray.append(correct4)
        correctAnswerArray.append(correct5)
        correctAnswerArray.append(correct6)
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
        userGuesses.append(userGuessTextFields[count].text!)
    }
    
    func updateCorrectLabels() {
        correctLabels.append(firstAnswer)
        correctLabels.append(secondAnswer)
        correctLabels.append(thirdAnswer)
        correctLabels.append(fourthAnswer)
        correctLabels.append(fifthAnswer)
        correctLabels.append(sixthAnswer)
        for index in 0...count {
            if(index == correctAnswers.count - 1) {
                submitButton.isHidden = true
                submitLabel.isHidden = true
                checkAnswersButton.isHidden = false
                checkAnswersLabel.isHidden = false
            }
            correctLabels[index].text = String(userGuesses[index])
        }
    }
    
    @IBAction func submitGuess(_ sender: Any) {
        updateTextFieldArray()
        getUserGuesses()
        updateCorrectLabels()
        correctLabels[count].isHidden = false
        userGuessTextFields[count].isHidden = true
        count += 1
        userGuessTextFields[count].becomeFirstResponder()
        if(count < 6) {
            userGuessTextFields[count].isHidden = false
        }
    }
    
    @IBAction func checkAnswers(_ sender: Any) {
        //checks users answers with correct answers
        for count in 0...userGuesses.count - 1 {
                if userGuesses[count] == String(correctAnswers[count]) {
                    correctLabels[count].textColor = green
                    correctGuesses += 1
                } else {
                    correctLabels[count].textColor = red
                }
        }
        for count in 0...correctAnswers.count - 1 {
            correctAnswerArray[count].isHidden = false
           correctAnswerArray[count].text = String(correctAnswers[count])
        }
        nextButton.isHidden = false
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
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "instructionsSegue2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! InstructionsViewController
        vc.index = 2
    }
}
