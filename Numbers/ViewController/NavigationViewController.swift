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
    @IBOutlet weak var viewStatisticsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var ex2Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startPractice(_ sender: Any) {
        performSegue(withIdentifier: "practiceSegue", sender: self)    }
    
    @IBAction func viewStatistics(_ sender: Any) {
        performSegue(withIdentifier: "statisticsSegue", sender: self)
    }
    
    @IBAction func viewSettings(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    @IBAction func startExTwo(_ sender: Any) {
        performSegue(withIdentifier: "ex2Segue", sender: self)
    }
    
    

}
