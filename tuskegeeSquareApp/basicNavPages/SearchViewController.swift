//
//  SearchViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseDatabase

private let reuseIdentifier = "DropDownCell"
class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    
    var tableView: UITableView!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
    func configureTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 34).isActive = true


    }
    @IBAction func searchClicked(_ sender: Any) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        guard let priceInput = priceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        db.collection("tuskegeeSquareServices").document(user!.uid).collection("services").whereField("servicePrice", isLessThanOrEqualTo: Int(priceInput)).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil{
                  print("\n***** RESULTS *****\n")

                for document in snapshot!.documents{
                    
                    print("Service Name: \(document.get("serviceName")!)")
                    print("Price: \(document.get("servicePrice")!)")
                    print("Service Type: \(document.get("serviceType")!)")
                    print("Description: \(document.get("serviceDescription")!)")
                    print("\n")
                    
                }
            }
            else{
               print("**** NO RESULTS FOUND ****")
            }
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
}
