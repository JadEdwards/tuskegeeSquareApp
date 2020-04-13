//
//  Profile.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addBusinessButton: UIButton!
    
    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Utilities.styleHollowButton(saveButton)
        Utilities.styleHollowButton(addBusinessButton)
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
        
    
    @IBAction func tapAddBus(_ sender: Any) {
        let addBusViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.addBusViewController) as? AddBusinessViewController
        
        view.window?.rootViewController = addBusViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func tapSave(_ sender: Any) {
        
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
             
             alert.addAction(UIAlertAction(title: "Sign In", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         case .signOut:
             let startViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.startViewController) as? StartViewController
         
             view.window?.rootViewController = startViewController
             view.window?.makeKeyAndVisible()

          }//end switch
    }//end transitionToNew()
    
    
}
extension ProfileViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
