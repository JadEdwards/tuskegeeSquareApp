//
//  HomeViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/9/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import TinyConstraints


class HomeViewController: UIViewController {
    var ref: DatabaseReference!
    let transition = SlideInTransition()
    //var results = [Results]()
   /* lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 500)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "documentData as? String"
        return label
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //view.addSubview(scrollView)
        //scrollView.addSubview(containerView)
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        db.collection("tuskegeeSquareServices").document(user!.uid).collection("services").getDocuments { (snapshot, error) in
                if error == nil && snapshot != nil{
                    for document in snapshot!.documents{
                        let documentData = document.data()
                        print(documentData)
                    }
                }
                else{
                    print("Error")
                }
        }
    }
    
    


    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController") as?
            MenuViewController else{ return }
        menuViewController.didTapMenuType = {menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType){
        let title = String(describing: menuType).capitalized
        self.title = title
        
        switch menuType{
        case .profile:
            let profileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
            
            view.window?.rootViewController = profileViewController
            view.window?.makeKeyAndVisible()
        case .home:
            let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
        case .businessSearch:
            let searchViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.searchViewController) as? SearchViewController
        
            view.window?.rootViewController = searchViewController
            view.window?.makeKeyAndVisible()
        case .business:
            let alert = UIAlertController(title: "Sign into Business Account", message: "please type your business name and the password you used to sign in", preferredStyle: .alert)
            
            alert.addTextField{(textField) in textField.placeholder = "Business Name"}
            alert.addTextField{(textField) in textField.placeholder = "Password"}
            alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { [weak alert] (_) in
                
                let currentUser = Auth.auth().currentUser
                
                let business = (alert?.textFields![0])! // Force unwrapping because we know it exists.
                print("Text field: \(String(describing: business.text))")
                let pass = (alert?.textFields![1])! // Force unwrapping because we know it exists.
                print("Text field: \(String(describing: pass.text))")

                let credential = EmailAuthProvider.credential(withEmail: (currentUser?.email!)!, password: String(describing: pass.text))
                print(credential)
                // use the reauthenticate method using the credential :
                currentUser?.reauthenticate(with: credential, completion: {(authResult, error) in
                    if error != nil{
                        print("NO ERROR")
                    }
                    else{
                        print("ERROR")
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .signOut:
            let startViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.startViewController) as? StartViewController
        
            view.window?.rootViewController = startViewController
            view.window?.makeKeyAndVisible()

        }//end switch
    }
}
extension HomeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
