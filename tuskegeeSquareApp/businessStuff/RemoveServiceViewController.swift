//
//  RemoveServiceViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class RemoveServiceViewController: UIViewController {
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func removeServicePressed(_ sender: UIButton) {
    }
    @IBAction func cancelPressed(_ sender: UIButton) {
        let bHomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.busHomeViewController) as? BusinessHomeViewController
        
            view.window?.rootViewController = bHomeViewController
            view.window?.makeKeyAndVisible()
    }
}
