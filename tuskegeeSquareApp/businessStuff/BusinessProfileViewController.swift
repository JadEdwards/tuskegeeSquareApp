//
//  BusinessProfileViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/12/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class BusinessProfileViewController: UIViewController {
    let transition = SlideInTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(identifier: "MenuViewController") as?
            MenuViewController else{ return }
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
    }//end func
}//end BusinessProfileViewController

extension BusinessProfileViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
