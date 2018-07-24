//
//  ViewController.swift
//  DeleteTableView
//
//  Created by admin on 6/29/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFied: UITextField!
    
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if name != nil {
            textFied.text = name
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if textFied.text != "" {
            name = textFied.text
        }
    
    }

}

