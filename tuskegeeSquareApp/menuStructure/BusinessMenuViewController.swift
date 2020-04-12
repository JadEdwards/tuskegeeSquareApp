//
//  BusinessMenuViewController.swift
//  tuskegeeSquareApp
//
//  Created by Jade Edwards on 4/12/20.
//  Copyright © 2020 Jade Edwards. All rights reserved.
//


import UIKit

enum MenuType: Int{
    case addNew
    case remove
    case studentPage

}
class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bMenuType = BusinessMenuType(rawValue: indexPath.row) else{return}
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(bMenuType)
        }
        
    }
}
