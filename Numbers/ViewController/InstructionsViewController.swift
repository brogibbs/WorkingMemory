//
//  InstructionsViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 7/2/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    var index = 0

    @IBOutlet weak var instructionsText: UITextView!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var beginLabel: UILabel!
    @IBOutlet weak var borderImage: UIImageView!
    @IBOutlet weak var brainImage2: UIImageView!
    @IBOutlet weak var brainImage1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsText.isEditable = false
        if(index == 1) {
            brainImage1.isHidden = false
            brainImage2.isHidden = true
            fillTextEx1()
        } else if(index == 2) {
            brainImage2.isHidden = false
            brainImage1.isHidden = true
            fillTextEx2()
        } else {
            brainImage1.isHidden = false
            brainImage2.isHidden = true
            fillTextEx3()
        }
    }
    
    func fillTextEx1() {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let firstAttributes = [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 24), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let secondAttributes =
        [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Light", size: 17), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let thirdAttributes =
            [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 20), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let firstString = NSMutableAttributedString(string: "\nYou will be shown a \n series of numbers.\n\n", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "Each number will show for \n one second and then the \n next number will occur. \n \n After all of the numbers \n have been shown, you will \n be asked to", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: " put the \n numbers in \n ascending order.", attributes: thirdAttributes)
        
        firstString.append(secondString)
        firstString.append(thirdString)
        instructionsText.attributedText = firstString
    }
    
    func fillTextEx2() {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let firstAttributes = [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 24), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let secondAttributes =
            [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Light", size: 16), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let thirdAttributes =
            [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 19), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let fourthAttributes =
            [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 16), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let firstString = NSMutableAttributedString(string: "\nYou will be shown a \n series of letters. \n", attributes: thirdAttributes)
        let secondString = NSAttributedString(string: "\nYou will be shown a series of six letters - one at a time. \n After all of the letters have \n been shown, you will see a line of puzzle pieces.", attributes: secondAttributes)
        let fourthString = NSAttributedString(string: "\nType the letter that corresponds to the shaded puzzle piece.\n ", attributes: secondAttributes)
        let fifthString = NSAttributedString(string: "\nFor example, if the first letter shown was A and ", attributes: secondAttributes)
        let sixthString = NSAttributedString(string: "the first puzzle piece was highlighted, you would enter A.", attributes: fourthAttributes)
        
        firstString.append(secondString)
        firstString.append(fourthString)
        firstString.append(fifthString)
        firstString.append(sixthString)
        
        instructionsText.attributedText = firstString
     /*   instructionsText.text = "You will be shown a series of six letters - one at a time. After all of the letters have been shown, you will see a line of puzzle pieces. One of these will be shaded. You will have to type in the letter that corresponds to that puzzle piece. For example, if the first letter shown was A and the first puzzle piece was highlighted, you would enter A." */
    }
    
    func fillTextEx3() {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let firstAttributes = [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 24), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let secondAttributes =
            [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Light", size: 17), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let thirdAttributes =
            [NSAttributedString.Key.font:  UIFont(name: "Montserrat-Bold", size: 20), NSAttributedString.Key.paragraphStyle: paragraph]
        
        let firstString = NSMutableAttributedString(string: "\nYou will be shown a \n series of circles.\n", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "\nClick the squares where the circles appeared in the same order they appeared.\n \n For each round you get correct, the number of circles will increase by one circle. \n\nIf you make two consecutive mistakes,", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: " the game will end.", attributes: thirdAttributes)
        
        firstString.append(secondString)
        firstString.append(thirdString)
        instructionsText.attributedText = firstString
        
       /* instructionsText.text = "You will be shown a series of circles. Click the squares where the circles appeared in the same order they appeared. For each round you get correct, the number of circles will increase by one circle. If you make two consecutive mistakes, the game will end. " */
    }
    
    
    
    @IBAction func begin(_ sender: Any) {
        if(index == 1) {
            performSegue(withIdentifier: "ex1Segue", sender: self)
        } else if(index == 2) {
            performSegue(withIdentifier: "ex2Segue", sender: self)
        } else {
            performSegue(withIdentifier: "ex3Segue", sender: self)
        }
    }
    
}
