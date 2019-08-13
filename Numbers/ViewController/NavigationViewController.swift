//
//  NavigationViewController.swift
//  Numbers
//
//  Created by Brooklyn Gibbs on 5/30/19.
//  Copyright © 2019 Brooklyn Gibbs. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    @IBOutlet weak var practiceButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var mainBrainImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "startSegue") {
            var vc = segue.destination as! InstructionsViewController
            vc.index = 1
        }
    }
    
    @IBAction func startPractice(_ sender: Any) {
        performSegue(withIdentifier: "startSegue", sender: self)    }
    
    @IBAction func viewStatistics(_ sender: Any) {
        performSegue(withIdentifier: "statisticsSegue", sender: self)
    }
    
    @IBAction func viewSettings(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    

}
