//
//  TextFieldsVC.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 19/2/2564 BE.
//

import Foundation
import UIKit
import iOSWidgets


class TextFieldsVC: UIViewController, TTBBaseWhiteDesign {
    
    @IBOutlet var textFields: [PrimaryTextField]!
    @IBOutlet var textViews: [PrimaryTextView]!
    
    var textFieldAction: ((UITextField) -> Void)? = { textField in
        if let tf = textField as? PrimaryTextField {
            tf.helpingText = "Hooo ley!!!"
        }
        print("TextField is selecting")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTitleNavigation(title: "TextFields")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
        
       textFields[2].action = textFieldAction
        
        setupLayout()
    }
    
    @IBAction func enableHandler(_ sender: UISegmentedControl) {
        let enable = (sender.selectedSegmentIndex != 1)
        let error = (sender.selectedSegmentIndex == 2) ? TestError.mismatch : nil
        for tf in textFields {
            tf.isEnabled = enable
            tf.error = error
        }
    }
    
    @objc func dismissKeyboard(){
        let tv = self.textViews[1] as PrimaryTextView
        tv.text = "Hello\nIt's me\n ***"
        view.endEditing(true)
    }
}
