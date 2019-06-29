//
//  Ex2ViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 6/11/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit
import AVFoundation

class Ex2ViewController: UIViewController {

    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var randomLetterText: UILabel!
    
    let uppercaseLetters = (65...90).map {String(UnicodeScalar($0))}
    
    let arraySize: Int = 6
    var answers = [String]()
    let secs = 1.5
    let maxSecs: Int = 7
    var runCount: Int = 0
    let voiceRate: Float = 0.51
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnswers()
    }
    
    func randomLetter() -> String {
        return uppercaseLetters.randomElement()!
    }
    
    func setAnswers() {
        var count = 0
        while(count < arraySize) {
            var temp = randomLetter()
            while(answers.contains(temp)) {
                temp = randomLetter()
            }
            answers.append(temp)
            count = count + 1
        }
        print(answers)
    }
    
    @IBAction func startLetters(_ sender: Any) {
        let timer1 = Timer.scheduledTimer(timeInterval: secs, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        beginButton.isHidden = true
    }
    
    @objc func fireTimer(timer: Timer) {
        if(runCount < maxSecs - 1) {
            randomLetterText.text = answers[runCount]
            speechToText()
        }
        runCount += 1
        
        if runCount == maxSecs {
            randomLetterText.text = ""
            timer.invalidate()
            performSegue(withIdentifier: "circleSegue", sender: self)
        }
    }
    
    func speechToText() {
        let utterance = AVSpeechUtterance(string: randomLetterText.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = voiceRate
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! CircleViewController
        vc.letters = self.answers
    }
    

}
