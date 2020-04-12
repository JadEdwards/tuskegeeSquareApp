//
//  HomeViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/9/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
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
