//
//  StartViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/9/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(signInButton)

    }
    
}

