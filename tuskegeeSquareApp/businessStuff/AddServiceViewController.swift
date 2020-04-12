//
//  AddServiceViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
    
 import UIKit
 import FirebaseAuth
 import Firebase
 import FirebaseDatabase

 class AddServiceViewController: UIViewController {
     
    @IBOutlet weak var serviceNameTextField: UITextField!
    @IBOutlet weak var servicePriceTextField: UITextField!
    @IBOutlet weak var serviceTypeTextField: UITextField!
    @IBOutlet weak var serviceDescriptionTextField: UITextField!
    @IBOutlet weak var addSerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
         Utilities.styleFilledButton(cancelButton)
         Utilities.styleHollowButton(addSerButton)
         ref = Database.database().reference()
     }
    
    //check fields and validate that the data is correct, if everything is correct this method returns nil otherwise it returns the error message
    func validateFields() -> String?
    {
        
        //check that all fields are filled in
        if serviceNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           servicePriceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            serviceTypeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || serviceDescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//end if field empty
        
        return nil
    }//end validateFields
    
    @IBAction func addServiceButton(_ sender: UIButton) {
        //validate the fields
        let error = validateFields()
        
        if error != nil
        {
            //There was an error
            let alertController = UIAlertController(title: "Error",
                                                    message: "Error Adding Service", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//if fields are filled
        else
        {
            //create cleaned versions of the data
            let servicename = serviceNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let serviceprice = servicePriceTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let servicetype = serviceTypeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let servicedes = serviceDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            
            db.collection("tuskegeeSquareServices").document(user!.uid).collection("services").addDocument(data:["serviceDescription": servicedes, "serviceName": servicename, "servicePrice": serviceprice, "serviceType": servicetype]);
            
            let bHomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.busHomeViewController) as? BusinessHomeViewController
            
                view.window?.rootViewController = bHomeViewController
                view.window?.makeKeyAndVisible()
            
        }//end else, add fields to auth
    }
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        let bHomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.busHomeViewController) as? BusinessHomeViewController
        
            view.window?.rootViewController = bHomeViewController
            view.window?.makeKeyAndVisible()
    }
}
