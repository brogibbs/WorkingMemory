//
//  ViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 5/28/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var runCount = 0
    var answers = [Int]()
    let maxSecs = 7
    let arraySize = 6
    let range = 0..<100
    
    @IBOutlet weak var currentNumberLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    
 
    @IBAction func startNumbers(_ sender: UIButton) {
        setAnswers()
        print(answers)
        let timer1 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        goButton.isHidden = true
        
    }
    
    @objc func fireTimer(timer: Timer) {
        if(runCount < maxSecs - 1) {
            currentNumberLabel.text = String(answers[runCount])
        }
        runCount += 1
        
        if runCount == maxSecs {
            currentNumberLabel.text = ""
            timer.invalidate()
            answers.sort()
            print(answers)
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setAnswers() {
        var count = 0
        while(count < arraySize) {
            var temp = Int.random(in: range)
            while(answers.contains(temp)) {
                temp = Int.random(in: range)
            }
            answers.append(temp)
            count = count + 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! AnswersViewController
        vc.correctAnswers = self.answers
    }
    
}
