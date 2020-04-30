//
//  BusinessHomeViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import TinyConstraints

class BusinessHomeViewController: UIViewController{
    @IBOutlet weak var profileButtn: UIButton!
   
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var addServiceButton: UIButton!
    
    @IBOutlet weak var editBusinessButton: UIButton!
    @IBOutlet weak var editServiceButton: UIButton!
    @IBOutlet weak var removeServiceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Utilities.styleHollowButton(addServiceButton)
        Utilities.styleHollowButton(editBusinessButton)
        Utilities.styleHollowButton(editServiceButton)
        Utilities.styleHollowButton(removeServiceButton)

        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        db.collection("tuskegeeSquareServices").document(user!.uid).collection("services").getDocuments { (snapshot, error) in
                if error == nil && snapshot != nil{
                    for document in snapshot!.documents{
                        let documentData = document.data()
                                                 
                        print(documentData.values)
                    }
                }
                else{
                    print("Error")
                }
        }
   }
   
    @IBAction func businessProfileClicked(_ sender: Any) {
        let businessProfileController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.businessProfileViewController) as? BusinessProfileViewController
        
            view.window?.rootViewController = businessProfileController
            view.window?.makeKeyAndVisible()
    }
}

