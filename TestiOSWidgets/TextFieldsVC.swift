//
//  TextFieldsVC.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 19/2/2564 BE.
//

import Foundation
import UIKit
import iOSWidgets


class TextFieldsVC: UIViewController, TTBBaseWhiteDesign {
    
    @IBOutlet var textFields: [PrimaryTextField]!
    @IBOutlet var textViews: [PrimaryTextView]!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFields.last?.font = .specialH1ForAccountSummaryPageWhiteRight
        
    }
    
    @IBAction func enableHandler(_ sender: UISegmentedControl) {
        let enable = (sender.selectedSegmentIndex == 1).revert
        let error = (sender.selectedSegmentIndex == 2) ? TestError.mismatch : nil
        for tf in textFields {
            tf.isEnabled = enable
            tf.error = error
        }
        for tv in textViews {
            tv.isEnabled = enable
            tv.error = error
        }
    }
    
    @objc func dismissKeyboard(){
        let tv = self.textViews[1] as PrimaryTextView
        tv.text = "Hello\nIt's me\n ***"
        view.endEditing(true)
    }
}
