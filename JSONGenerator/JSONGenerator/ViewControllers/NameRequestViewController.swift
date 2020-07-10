//
//  NameRequestViewController.swift
//  JSONGenerator
//
//  Created by Gustavo Vilas Boas on 10/07/20.
//  Copyright © 2020 Gustavo Vilas Boas. All rights reserved.
//

import Cocoa

class NameRequestViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    
    var rect : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func confirm(_ sender: Any) {
        guard let rect = self.rect, textField.stringValue != "" else {return}
        
        
    }
}
