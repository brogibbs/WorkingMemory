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
    
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var letterTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    let circleRadius: CGFloat = 25
    let width: CGFloat = 40
    var randomNum = Int.random(in: 1 ..< 7)
    var letters = [String]()
    var didGuess = false
    var maxCircles: CGFloat = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        createCirles()
    }
    
    public var screenWidth: CGFloat {
       return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func createCirles() {
        var circleCenter = CGPoint(x: self.screenWidth - circleRadius, y: self.screenHeight / 2 - circleRadius)
        var num: CGFloat = 0
        while(num <= maxCircles) {
            if(num == 0) {
                circleCenter = CGPoint(x: self.screenWidth - circleRadius * 2, y: self.screenHeight / 2 - circleRadius)
            } else {
                circleCenter = CGPoint(x: self.screenWidth / 6  *  num - circleRadius * 2, y: self.screenHeight / 2 - circleRadius)
            }
         
         // Set a random Circle Radius
         // 2
         let circleWidth = width
         let circleHeight = circleWidth
         
         // Create a new CircleView
         // 3
         let circleView = CircleView(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: circleWidth, height: circleHeight))
            
         if(Int(num) == randomNum) {
            circleView.backgroundColor = UIColor.green
         }
         view.addSubview(circleView)
         num += 1
        }
        letterTextField.isHidden = false
        textLabel.isHidden = false
        submitButton.isHidden = false
    }
    
    @IBAction func checkAnswers(_ sender: Any) {
        print(letters)
        print(randomNum)
        if(letterTextField.text?.uppercased() == letters[randomNum - 1].uppercased()) {
            letterTextField.backgroundColor = UIColor.green
            didGuess = true
        } else {
            letterTextField.backgroundColor = UIColor.red
        }
        submitButton.isEnabled = false
        backButton.isHidden = false
        
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
    
    @IBAction func backToNav(_ sender: Any) {
        performSegue(withIdentifier: "circleToNav", sender: self)
    }
    

}
