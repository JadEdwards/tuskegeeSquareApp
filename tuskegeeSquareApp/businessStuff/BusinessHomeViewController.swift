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
    let transition = SlideInTransition()
    
    @IBOutlet weak var businessNameLabel: UILabel!
    
/*lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
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
        view.backgroundColor = .white
        //view.addSubview(scrollView)
        //scrollView.addSubview(containerView)
        
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
    
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
       guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController else{ return }
        menuViewController.didTapBMenuType = {bMenuType in
                self.transitionToNew(bMenuType)
            }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
        
    func transitionToNew(_ menuType: BMenuType){
        let title = String(describing: menuType).capitalized
        self.title = title
        
        switch menuType{
            
            case .addNew:
                let addViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.addServiceViewController) as? AddServiceViewController
            
                view.window?.rootViewController = addViewController
                view.window?.makeKeyAndVisible()
            case .remove:
                let removeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.removeServiceViewController) as? RemoveServiceViewController
            
                view.window?.rootViewController = removeViewController
                view.window?.makeKeyAndVisible()
            case .profile:
                let bProfileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.businessProfileViewController) as? BusinessProfileViewController
                
                view.window?.rootViewController = bProfileViewController
                view.window?.makeKeyAndVisible()
           case .studentPage:
                let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                    view.window?.rootViewController = homeViewController
                    view.window?.makeKeyAndVisible()
            }//end switch
    }
}

extension BusinessHomeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
