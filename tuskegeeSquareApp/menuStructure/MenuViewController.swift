//
//  MenuViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/11/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//

import UIKit

enum MenuType: Int{
    case home
    case businessSearch
    case profile
    case business
    case signOut
    
}
enum BMenuType: Int{
    case profile
    case studentPage
}
class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?
    var didTapBMenuType: ((BMenuType) -> Void)?
    
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.systemYellow
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else{return}
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(menuType)
        
        }
        guard let bMenuType = BMenuType(rawValue: indexPath.row) else{return}
        dismiss(animated: true) { [weak self] in
            self?.didTapBMenuType?(bMenuType)
                
            
        }
        
    }
}
    

   

