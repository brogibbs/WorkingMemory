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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var line1: UIImageView!
    @IBOutlet weak var line2: UIImageView!
    @IBOutlet weak var line3: UIImageView!
    @IBOutlet weak var line4: UIImageView!
    @IBOutlet weak var line5: UIImageView!
    
    
    @IBOutlet weak var circle1: UIImageView!
    @IBOutlet weak var circle2: UIImageView!
    @IBOutlet weak var circle3: UIImageView!
    @IBOutlet weak var circle4: UIImageView!
    @IBOutlet weak var circle5: UIImageView!
    @IBOutlet weak var circle6: UIImageView!
    @IBOutlet weak var circle7: UIImageView!
    @IBOutlet weak var circle8: UIImageView!
    @IBOutlet weak var circle9: UIImageView!
    @IBOutlet weak var circle10: UIImageView!
    @IBOutlet weak var circle11: UIImageView!
    @IBOutlet weak var circle12: UIImageView!
    
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet var tapGesture1: UITapGestureRecognizer!
    
    var circleList = [UIImageView]()
    var circleOrder = [Int]()
    @IBOutlet weak var levelLabel: UILabel!
    var tapCount = 0
    var livesLeft = 2
    //SET SPEED
    let secs = 0.7
    @IBOutlet weak var tryAgainBar: UIImageView!
    
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
        tryAgainBar.isHidden = true
        setCircleArray()
        setCircleOrder()
        runNextLevel()

    }
    
    func setCircleArray() {
        circleList.append(circle1)
        circleList.append(circle2)
        circleList.append(circle3)
        circleList.append(circle4)
        circleList.append(circle5)
        circleList.append(circle6)
        circleList.append(circle7)
        circleList.append(circle8)
        circleList.append(circle9)
        circleList.append(circle10)
        circleList.append(circle11)
        circleList.append(circle12)
    }
    
    func setCircleOrder() {
        for index in 0...2 {
            circleOrder.append(getRandomCircleNum())
        }
    }
    
    func getRandomCircleNum() -> Int {
        var randomNum = Int.random(in: 0 ..< circleList.count)
        while(circleOrder.count > 0 && randomNum == circleOrder[circleOrder.count - 1]) {
            randomNum = Int.random(in: 0 ..< circleList.count)
            
        }
        return randomNum
    }
    
    func runNextLevel() {
        circleOrder.append(getRandomCircleNum())
        runLevel()
    }
    
    
    func runLevel(fromIndex index: Int = 0) {
        tapCount = 0
        self.view.isUserInteractionEnabled = false
        incorrectLabel.isHidden = true
        tryAgainBar.isHidden = true
        guard index < circleOrder.count else {
            self.view.isUserInteractionEnabled = true
            return
        }
        circleList[circleOrder[index]].isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + secs) {
           self.circleList[self.circleOrder[index]].isHidden = true
        }
        Timer.scheduledTimer(withTimeInterval: secs, repeats: false) { _ in
            self.runLevel(fromIndex: index+1)
        }
    }
    
    func showUserGuess(userGuess: Int) {
        circleList[userGuess].isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.circleList[userGuess].isHidden = true
        }
    }
    
    func isCorrectGuess(userGuess: Int) -> Bool {
        return userGuess == circleOrder[tapCount]
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        incorrectLabel.isHidden = true
        tryAgainBar.isHidden = true
        let touch: UITouch = touches.first as! UITouch
        if(tapCount < circleOrder.count) {
            var userBoxGuess = getCorrectBoxWithCorrdinates(touchPoint: touch.location(in: view))
            showUserGuess(userGuess: userBoxGuess)
            if(isCorrectGuess(userGuess: userBoxGuess)) {
                if (tapCount == circleOrder.count - 1) {
                    livesLeft = 2
                }
            } else {
                livesLeft -= 1
                incorrectLabel.isHidden = false
                tryAgainBar.isHidden = false
                if(livesLeft == 0) {
                    quitGame()
                } else {
                    tapCount = -1
                    self.view.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.incorrectLabel.isHidden = false
                        self.tryAgainBar.isHidden = false
                        self.runLevel()
                    }
                }
            }
        }
        if(tapCount == circleOrder.count - 1) {
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
        
        if 46...(46+95) ~= touchPoint.x {
            //BOX 1
            if 93...(93 + 121) ~= touchPoint.y {
               return 0
            }
            //BOX 4
            if 214...214 + 121 ~= touchPoint.y {
                return 3
            }
            //BOX 7
            if 333...333+121 ~= touchPoint.y {
                return 6
            }
            //BOX 10
            if 452...452+121 ~= touchPoint.y {
                return 9
            }
        }
        
        if (141...141+95) ~= touchPoint.x {
            //BOX 2
            if 93...(93 + 121) ~= touchPoint.y {
                return 1
            }
            //BOX 5
            if 214...214 + 121 ~= touchPoint.y {
                return 4
            }
            //BOX 8
            if 333...333+121 ~= touchPoint.y {
                return 7
            }
            //BOX 11
            if 452...452+121 ~= touchPoint.y {
                return 10
            }
        }
        
        if (234...234+95) ~= touchPoint.x {
            //BOX 3
            if 93...(93 + 121) ~= touchPoint.y {
                return 2
            }
            //BOX 6
            if 214...214 + 121 ~= touchPoint.y {
                return 5
            }
            //BOX 9
            if 333...333+121 ~= touchPoint.y {
                return 8
            }
            //BOX 12
            if 452...452+121 ~= touchPoint.y {
                return 11
            }
        }
        return -1
    }
    
    func quitGame() {
        incorrectLabel.text = "END"
        incorrectLabel.isHidden = false
        tryAgainBar.isHidden = false
        for box in circleList {
      //      setGrid(color: UIColor.white.cgColor)
            box.backgroundColor = UIColor.white
        }
        
        //entity set up
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Ex3Trials", in: context)
        let newTrial = NSManagedObject(entity: entity!, insertInto: context)
        
        //set values for trial entitiy
        newTrial.setValue(circleOrder.count - 1, forKey: "level")
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

