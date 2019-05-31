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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startPractice(_ sender: Any) {
        performSegue(withIdentifier: "practiceSegue", sender: self)    }
    
    @IBAction func viewStatistics(_ sender: Any) {
        performSegue(withIdentifier: "statisticsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "practiceSegue") {
            var vc = segue.destination as! ViewController
        } else if(segue.identifier == "statisticsSegue") {
            var vc = segue.destination as! StatisticsViewController
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
