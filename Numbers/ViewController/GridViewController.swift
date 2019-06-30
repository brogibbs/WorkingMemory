//
//  GridViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 6/19/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit
import CoreData

// make circles disappear once it says try again
class GridViewController: UIViewController {
    
    @IBOutlet weak var box1: UILabel!
    @IBOutlet weak var box2: UILabel!
    @IBOutlet weak var box3: UILabel!
    @IBOutlet weak var box4: UILabel!
    @IBOutlet weak var box5: UILabel!
    @IBOutlet weak var box6: UILabel!
    @IBOutlet weak var box7: UILabel!
    @IBOutlet weak var box8: UILabel!
    @IBOutlet weak var box9: UILabel!
    @IBOutlet weak var box10: UILabel!
    @IBOutlet weak var box11: UILabel!
    @IBOutlet weak var box12: UILabel!
    
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet var tapGesture1: UITapGestureRecognizer!
    
    var boxList = [UILabel]()
    var boxOrder = [Int]()
    @IBOutlet weak var levelLabel: UILabel!
    var tapCount = 0
    var livesLeft = 2
    let secs = 0.7
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture1.isEnabled = false
        incorrectLabel.isHidden = true
        setGrid(color: UIColor.black.cgColor)
        setArray()
        setBoxOrder()
        setLevel()
        runNextLevel()

    }
    
    func setGrid(color: CGColor) {
        //vertical lines
        addLine(fromPoint: CGPoint(x: screenWidth * (1/3), y: 0), toPoint: CGPoint(x: screenWidth * (1/3), y: screenHeight), color: color)
        addLine(fromPoint: CGPoint(x: screenWidth * (2/3), y: 0), toPoint: CGPoint(x: screenWidth * (2/3), y: screenHeight), color: color)
        
        //horizontal lines
        addLine(fromPoint: CGPoint(x: 0, y: screenHeight * (1/4)), toPoint: CGPoint(x: screenWidth, y: screenHeight * (1/4)), color: color)
        addLine(fromPoint: CGPoint(x: 0, y: screenHeight * (2/4)), toPoint: CGPoint(x: screenWidth, y: screenHeight * (2/4)), color: color)
        addLine(fromPoint: CGPoint(x: 0, y: screenHeight * (3/4)), toPoint: CGPoint(x: screenWidth, y: screenHeight * (3/4)), color: color)
    }
    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint, color: CGColor) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = color
        line.lineWidth = 1
        line.lineJoin = CAShapeLayerLineJoin.round
        self.view.layer.addSublayer(line)
    }
    
    func setArray() {
        boxList.append(box1)
        boxList.append(box2)
        boxList.append(box3)
        boxList.append(box4)
        boxList.append(box5)
        boxList.append(box6)
        boxList.append(box7)
        boxList.append(box8)
        boxList.append(box9)
        boxList.append(box10)
        boxList.append(box11)
        boxList.append(box12)
    }
    
    func setLevel() {
      levelLabel.text = "Level " + String(boxOrder.count - 2)
    }
    
    func getRandomBoxNum() -> Int {
        var randomNum = Int.random(in: 0 ..< boxList.count)
        while(boxOrder.count > 0 && randomNum == boxOrder[boxOrder.count - 1]) {
            randomNum = Int.random(in: 0 ..< boxList.count)
            
        }
        return randomNum
    }
        
    
    func setBoxOrder() {
        for index in 0...2 {
            boxOrder.append(getRandomBoxNum())
        }
    }
    
    
    func runNextLevel() {
        boxOrder.append(getRandomBoxNum())
        runLevel()
    }
    
    
    func runLevel(fromIndex index: Int = 0) {
        tapCount = 0
        setLevel()
        self.view.isUserInteractionEnabled = false
        incorrectLabel.isHidden = true
        guard index < boxOrder.count else {
            self.view.isUserInteractionEnabled = true
            return
        }
        boxList[boxOrder[index]].text = "O"
        DispatchQueue.main.asyncAfter(deadline: .now() + secs) {
            self.boxList[self.boxOrder[index]].text = ""
        }
        Timer.scheduledTimer(withTimeInterval: secs, repeats: false) { _ in
            self.runLevel(fromIndex: index+1)
        }
    }
    
    func showUserGuess(userGuess: Int) {
        boxList[userGuess].textColor = UIColor.red
        boxList[userGuess].text = "O"
        DispatchQueue.main.asyncAfter(deadline: .now() + secs) {
            self.boxList[userGuess].text = ""
            self.boxList[userGuess].textColor = UIColor.black
        }
    }
    
    func isCorrectGuess(userGuess: Int) -> Bool {
        return userGuess == boxOrder[tapCount]
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        incorrectLabel.isHidden = true
        let touch: UITouch = touches.first as! UITouch
        if(tapCount < boxOrder.count) {
            var userBoxGuess = getCorrectBoxWithCorrdinates(touchPoint: touch.location(in: view))
            showUserGuess(userGuess: userBoxGuess)
            if(isCorrectGuess(userGuess: userBoxGuess)) {
                    livesLeft = 2
            } else {
                livesLeft -= 1
                incorrectLabel.isHidden = false
                if(livesLeft == 0) {
                    quitGame()
                } else {
                    for box in boxList {
                        //clear grid
                        setGrid(color: UIColor.white.cgColor)
                        box.backgroundColor = UIColor.white
                    }
                    tapCount = -1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.setGrid(color: UIColor.black.cgColor)
                        self.incorrectLabel.isHidden = false
                        self.runLevel()
                    }
                }
            }
        }
        if(tapCount == boxOrder.count - 1) {
           DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.runNextLevel()
            }
        }
        tapCount += 1
    }
    
    func getCorrectBoxWithCorrdinates(touchPoint: CGPoint) -> Int {
      //  print(screenWidth * (1/3)) - 125
      //  print(screenWidth * (2/3)) - 250
      //  print(screenWidth) - 375
        
      // print(screenHeight * (1/4)) - 166.75
      //  print(screenHeight * (2/4)) - 333.5
      //  print(screenHeight * (3/4)) - 500.25
      // print(screenHeight) - 667.0
        
        if 0...(screenWidth * (1/3)) ~= touchPoint.x {
            //BOX 1
            if 0...(screenHeight * (1/4)) ~= touchPoint.y {
               return 0
            }
            //BOX 4
            if (screenHeight * (1/4))...screenHeight * (2/4) ~= touchPoint.y {
                return 3
            }
            //BOX 7
            if (screenHeight * (2/4))...screenHeight * (3/4) ~= touchPoint.y {
                return 6
            }
            //BOX 10
            if (screenHeight * (3/4))...screenHeight ~= touchPoint.y {
                return 9
            }
        }
        
        if (screenWidth * (1/3)...screenWidth * (2/3)) ~= touchPoint.x {
            //BOX 2
            if 0...(screenHeight * (1/4)) ~= touchPoint.y {
                return 1
            }
            //BOX 5
            if (screenHeight * (1/4))...screenHeight * (2/4) ~= touchPoint.y {
                return 4
            }
            //BOX 8
            if (screenHeight * (2/4))...screenHeight * (3/4) ~= touchPoint.y {
                return 7
            }
            //BOX 11
            if (screenHeight * (3/4))...screenHeight ~= touchPoint.y {
                return 10
            }
        }
        
        if (screenWidth * (2/3)...screenWidth) ~= touchPoint.x {
            //BOX 3
            if 0...(screenHeight * (1/4)) ~= touchPoint.y {
                return 2
            }
            //BOX 6
            if (screenHeight * (1/4))...screenHeight * (2/4) ~= touchPoint.y {
                return 5
            }
            //BOX 9
            if (screenHeight * (2/4))...screenHeight * (3/4) ~= touchPoint.y {
                return 8
            }
            //BOX 12
            if (screenHeight * (3/4))...screenHeight ~= touchPoint.y {
                return 11
            }
        }
        return -1
    }
    
    func quitGame() {
        incorrectLabel.text = "END"
        incorrectLabel.isHidden = false
        for box in boxList {
            setGrid(color: UIColor.white.cgColor)
            box.backgroundColor = UIColor.white
            box.textColor = UIColor.white
        }
        
        //entity set up
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Ex3Trials", in: context)
        let newTrial = NSManagedObject(entity: entity!, insertInto: context)
        
        //set values for trial entitiy
        newTrial.setValue(boxOrder.count - 1, forKey: "level")
        newTrial.setValue(Date(), forKey: "userDate")
        
        //save entity data
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "returnHome", sender: self)
        }
    }
    
}

