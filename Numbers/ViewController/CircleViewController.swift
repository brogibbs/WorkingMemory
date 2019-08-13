//
//  CircleViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 6/11/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit
import CoreData


class CircleViewController: UIViewController {
    
    var puzzleImageArray: [UIImageView] = []
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var letterTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitLabel: UILabel!
    
    let circleRadius: CGFloat = 25
    let width: CGFloat = 40
    var randomNum = Int.random(in: 0 ..< 6)
    var letters = [String]()
    var didGuess = false
    var maxCircles: CGFloat = 6
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var whitePieces: UIImageView!
    @IBOutlet weak var blackPiece1: UIImageView!
    @IBOutlet weak var blackPiece2: UIImageView!
    @IBOutlet weak var blackPiece3: UIImageView!
    @IBOutlet weak var blackPiece4: UIImageView!
    @IBOutlet weak var blackPiece5: UIImageView!
    @IBOutlet weak var blackPiece6: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterTextField.borderStyle = UITextField.BorderStyle.roundedRect
        letterTextField.becomeFirstResponder()
        setPuzzleArray()
        highlightImage()
    }
    
    func setPuzzleArray() {
        puzzleImageArray.append(blackPiece1)
        puzzleImageArray.append(blackPiece2)
        puzzleImageArray.append(blackPiece3)
        puzzleImageArray.append(blackPiece4)
        puzzleImageArray.append(blackPiece5)
        puzzleImageArray.append(blackPiece6)
    }
    
    func highlightImage() {
        puzzleImageArray[randomNum].isHidden = false
        letterTextField.isHidden = false
        textLabel.isHidden = false
        textLabel2.isHidden = false
        submitButton.isHidden = false
        submitLabel.isHidden = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! InstructionsViewController
        vc.index = 3
    }
    
    @IBAction func checkAnswers(_ sender: Any) {
        if(letterTextField.text?.uppercased() == letters[randomNum].uppercased()) {
            letterTextField.backgroundColor = UIColor(red:0.41, green:0.71, blue:0.68, alpha:1.0)
            didGuess = true
        } else {
            letterTextField.backgroundColor = UIColor(red:0.81, green:0.53, blue:0.63, alpha:1.0)
        }
        submitLabel.isHidden = false
        submitButton.isEnabled = false
        nextButton.isHidden = false
        correctLabel.text = letters[randomNum]
        correctLabel.isHidden = false
        
        //entity set up
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Ex2Trials", in: context)
        let newTrial = NSManagedObject(entity: entity!, insertInto: context)
        
        newTrial.setValue(didGuess, forKey: "didGuess")
        newTrial.setValue(maxCircles, forKey: "level")
        newTrial.setValue(Date(), forKey: "userDate")
        
        //save entity data
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    @IBAction func nextEx(_ sender: Any) {
        performSegue(withIdentifier: "nextEx2", sender: self)
    }
}
