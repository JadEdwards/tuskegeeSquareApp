//
//  SignUpViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/9/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var passTextFieldRe: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }//end viewDidLoad()
    
    func setUpElements()
    {
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(userNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passTextField)
        Utilities.styleTextField(passTextFieldRe)
        Utilities.styleHollowButton(signUpButton)

    }//end setUpElements()
    
    //check fields and validate that the data is correct, if everything is correct this method returns nil otherwise it returns the error message
    func validateFields() -> String?
    {
        
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passTextFieldRe.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please fill in all fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//end if field empty
        
        //check that passwords are the same
        if passTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != passTextFieldRe.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            let alertController = UIAlertController(title: "Error",
                                                    message: "Passwords do not match", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//end if fields do not match
        
        //check if password is secure
        let cleanedPassword = passTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            //password isnt secure enough
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please make sure your password is at least 8 characters, contains a special character and a number", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }//end if password is not good
        
        return nil
    }//end validateFields
    
    @IBAction func signUpTapped(_ sender: Any) {

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
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let userName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil{
                    //there was an error
                    let alertController = UIAlertController(title: "Error",
                                                            message: "Error creating user", preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                }//end if
                else
                {
                    //user was created successfully
                    let db = Firestore.firestore()

                    db.collection("tuskegeeSquareUsers").addDocument(data: ["firstname":firstName, "lastname":lastName, "username":userName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil{
                            //show error message
                            let alertController = UIAlertController(title: "Error",
                                                                    message: "Error saving data", preferredStyle: UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }//end if error
                    }//end db
                    //transition to the home screen
                    self.transitionToHome()
                }//end else
            }//end Auth.auth().createUser
        }//end else, add fields to auth
    }//end signUpTapped()
    
    func transitionToHome()
    {
        let welcomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.welcomeViewController) as? WelcomeViewController
        
        view.window?.rootViewController = welcomeViewController
        view.window?.makeKeyAndVisible()
    }//end transitionToHome()
}//end SignUpViewController
