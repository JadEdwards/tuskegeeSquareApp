//
//  AddBusinessViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class AddBusinessViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addBusButton: UIButton!
    
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var businessTypeTextField: UITextField!
    @IBOutlet weak var businessLocationTextField: UITextField!
    
    @IBOutlet weak var accountPassword: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Utilities.styleFilledButton(cancelButton)
        Utilities.styleHollowButton(addBusButton)
        ref = Database.database().reference()
    }
    
    //check fields and validate that the data is correct, if everything is correct this method returns nil otherwise it returns the error message
    func validateFields() -> String?
    {
        
        //check that all fields are filled in
        if businessNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            businessTypeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            businessLocationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//end if field empty
        
        return nil
    }//end validateFields
    
    @IBAction func addBusinessTapped(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        
        if error != nil
        {
            //There was an error
            let alertController = UIAlertController(title: "Error",
                                                    message: "Error signing up", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//if fields are filled
        else
        {
            //create cleaned versions of the data
            
            let businessname = businessNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let businessType = businessTypeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let businessLocation = businessLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
            
            db.collection("tuskegeeSquareBusiness").document(businessname).setData(["businessName": businessname, "category": businessType, "location": businessLocation]);
            
            
            
            let busHomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.busHomeViewController) as? BusinessHomeViewController
            
            view.window?.rootViewController = busHomeViewController
            view.window?.makeKeyAndVisible()
            
        }//end else, add fields to auth
    }
    func getBusiness() -> String{
        let businessname = businessNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return businessname
    }
    @IBAction func cancelTapped(_ sender: Any) {
        let profileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
        
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
    
}
