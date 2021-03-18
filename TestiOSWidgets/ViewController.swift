//
//  ViewController.swift
//  ComponentTest
//
//  Created by SIDDHANT-TCS on 16/2/2564 BE.
//

import UIKit
import iOSWidgets

class ViewController: UIViewController, TTBBaseBlueDesign {

    @IBOutlet var buttons: [UIButton]!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTitleNavigation(title: "Components Labs")
        setupLayout()
    }

    @IBAction func enableHandler(_ sender: UISegmentedControl) {
        let enable = (sender.selectedSegmentIndex == 0)
    
        for button in buttons {
            button.isEnabled = enable
        }
    }
    
   
    
}

enum TestError: PrimaryError {
    case mismatch
    
    var description: String? {
        return "Please Input valid data"
    }
}

