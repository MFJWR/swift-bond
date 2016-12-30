//
//  ViewController.swift
//  SwiftBond
//
//  Created by Kento Haneda on 2016/12/18.
//  Copyright © 2016年 Kento Haneda. All rights reserved.
//

import UIKit
import Bond

class StartViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input.bnd_text
            .bind(to: label.bnd_text)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
