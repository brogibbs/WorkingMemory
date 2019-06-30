//
//  StatsViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 6/10/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit
import CoreData

class StatsViewController: UIViewController {
    var dataText = ""
    @IBOutlet weak var textScrollLabel: UITextView!
    @IBOutlet weak var ex1Button: UIButton!
    @IBOutlet weak var ex2Button: UIButton!
    @IBOutlet weak var ex3Button: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getEx1Stats(_ sender: Any) {
        ex1Button.isHidden = true
        ex2Button.isHidden = true
        ex3Button.isHidden = true
        textScrollLabel.isEditable = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Trials")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                dataText += ("DATE: ")
                var userDate: Date = data.value(forKey: "userDate") as! Date
                dataText += (userDate.asString(style: .medium))
                dataText += ("\n")
                dataText += ("LEVEL:  ")
                dataText += String(data.value(forKey: "level") as! Int)
                dataText += ("\n")
                dataText += ("CORRECT GUESSES:  ")
                dataText += String(data.value(forKey: "correctGuesses") as! Int16)
                dataText += ("\n")
                dataText += ("\n")
            }
            textScrollLabel.text = dataText
            dataText += ("\n")
            
        } catch {
            print("Failed")
        }
        backButton.isHidden = false
    }
    
    @IBAction func getEx2Stats(_ sender: Any) {
        ex1Button.isHidden = true
        ex2Button.isHidden = true
        ex3Button.isHidden = true
        textScrollLabel.isEditable = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ex2Trials")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                dataText += ("DATE: ")
                var userDate: Date = data.value(forKey: "userDate") as! Date
                dataText += (userDate.asString(style: .medium))
                dataText += ("\n")
                dataText += ("LEVEL:  ")
                dataText += String(data.value(forKey: "level") as! Int)
                dataText += ("\n")
                dataText += ("DID USER GUESS CORRECTLY:  ")
                if(data.value(forKey: "didGuess") as! Bool == true) {
                    dataText += "Yes"
                } else {
                    dataText += "No"
                }
                dataText += ("\n")
                dataText += ("\n")
            }
            textScrollLabel.text = dataText
            dataText += ("\n")
            
        } catch {
            print("Failed")
        }
        backButton.isHidden = false
    }
    
    @IBAction func getEx3Stats(_ sender: Any) {
        ex1Button.isHidden = true
        ex2Button.isHidden = true
        ex3Button.isHidden = true
        textScrollLabel.isEditable = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ex3Trials")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                dataText += ("DATE: ")
                var userDate: Date = data.value(forKey: "userDate") as! Date
                dataText += (userDate.asString(style: .medium))
                dataText += ("\n")
                dataText += ("CIRCLES SHOWN:  ")
                dataText += String(data.value(forKey: "level") as! Int)
                dataText += ("\n")
                dataText += ("\n")
                dataText += ("\n")
            }
            textScrollLabel.text = dataText
            dataText += ("\n")
            
        } catch {
            print("Failed")
        }
        backButton.isHidden = false
    }
    
    @IBAction func backToNav(_ sender: Any) {
        performSegue(withIdentifier: "statsToNav", sender: self)
    }
    
}

extension Date {
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
