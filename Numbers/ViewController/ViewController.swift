//
//  ViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 5/28/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController {
    
    var container: NSPersistentContainer!
    var runCount: Int = 0
    var answers = [Int]()
    let maxSecs: Int = 7
    let arraySize: Int = 6
    let range: Range = 0..<100
    let voiceRate: Float = 0.50
    var correctAnswers = 0;
    let secs = 1.5
    @IBOutlet weak var currentNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnswers()
        startNumbers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! AnswersViewController
        vc.correctAnswers = self.answers
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
 
    func startNumbers() {
        let timer1 = Timer.scheduledTimer(timeInterval: secs, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer(timer: Timer) {
        if(runCount < maxSecs - 1) {
            currentNumberLabel.text = String(answers[runCount])
            speechToText()
        }
        runCount += 1
        
        if runCount == maxSecs {
            currentNumberLabel.text = ""
            timer.invalidate()
            answers.sort()
            performSegue(withIdentifier: "ex1AnswersSegue", sender: self)
        }
    }
    
    func speechToText() {
        let utterance = AVSpeechUtterance(string: currentNumberLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = voiceRate
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
