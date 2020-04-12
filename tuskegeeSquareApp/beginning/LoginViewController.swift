//
//  LoginViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/9/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController
{

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }//end viewDidLoad()
    
    func setUpElements(){
        
        Utilities.styleTextField(userTextField)
        Utilities.styleTextField(passwTextField)
        Utilities.styleHollowButton(loginButton)
    }//setUpElements()
    
    func validateFields() -> String?
    {
        //check that all fields are filled in
        if userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//end if field empty
        
        return nil
    }//end validateFields
    
    @IBAction func logInTapped(_ sender: Any)
    {
        //validate textfields
        let error = validateFields()
        
        if error != nil
        {
            //There was an error
            let alertController = UIAlertController(title: "Error",
                                                    message: "Error signing in", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//if fields are filled
        else{
            //create cleaned versions if text field
            let username = userTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            //signing in user
            Auth.auth().signIn(withEmail: username, password: password) { (reult, error) in
                if error != nil{
                    //there was an error
                   let alertController = UIAlertController(title: "Error",
                                                           message: "User does not exist, check username and password or signup", preferredStyle: UIAlertController.Style.alert)
                   alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alertController, animated: true, completion: nil)
                }//end if
                else
                {
                    let welcomeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.welcomeViewController) as? WelcomeViewController
                    
                    self.view.window?.rootViewController = welcomeViewController
                    self.view.window?.makeKeyAndVisible()
                }//end else
            }//end Auth.auth()
        }//end else
    }// logInTapped()
    
    
    
}//end LoginViewController()
