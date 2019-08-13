//
//  AnswersViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 5/29/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//
import UIKit
import CoreData

class AnswersViewController: UIViewController, UITextFieldDelegate {
    
    var correctAnswers = [Int]()
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
        self.firstGuess.addTarget(self, action: #selector(onReturn), for: UIControl.Event.editingDidEndOnExit)
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onReturn))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.firstGuess.inputAccessoryView = toolbar
    }
    
    func createAnswerArray() {
        correctAnswerArray.append(correct1)
        correctAnswerArray.append(correct2)
        correctAnswerArray.append(correct3)
        correctAnswerArray.append(correct4)
        correctAnswerArray.append(correct5)
        correctAnswerArray.append(correct6)
    }
    
    func getUserGuesses() {
        userGuesses.append(firstGuess.text!)
        firstGuess.text = ""
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
        getUserGuesses()
        updateCorrectLabels()
        correctLabels[count].isHidden = false
        count += 1
    }
    
    @IBAction func onReturn(_ sender: Any) {
        self.firstGuess.resignFirstResponder()
        var num = Int(firstGuess.text!)
        if(num != nil) {
            submitGuess(sender)
        }
        if(count < correctAnswerArray.count) {
           self.firstGuess.becomeFirstResponder()
        } else {
            self.firstGuess.endEditing(true)
            self.firstGuess.isEnabled = false
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
        checkAnswersButton.isHidden = true
        checkAnswersLabel.isHidden = true
        
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
