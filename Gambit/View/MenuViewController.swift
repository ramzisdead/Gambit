//
//  ViewController.swift
//  Gambit
//
//  Created by Рамазан on 17.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit
import SDWebImage


protocol MenuViewProtocol {
    func setMenuItems(items: [MenuItem])
}


class MenuViewController: UIViewController {
    
    let menuTableView = UITableView()
    let cellID = "MyCell"
    
    var menuPresenter: MenuPresenterProtocol?
    
    var menuItems: [MenuItem] = [] {
        didSet {
            menuTableView.reloadData()
        }
    }
    
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPresenter = MenuPresenter(view: self)
        
        createMenuTableView()
        editNavBar()
    }

}


// MARK: - View Building

extension MenuViewController {
    
    func createMenuTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        view.addSubview(menuTableView)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        menuTableView.register(MenuCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    func editNavBar() {
        let titleImage = UIImage(named: "GambitTitle")
        let imageView = UIImageView(image: titleImage)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9717701077, green: 0, blue: 0.5715600848, alpha: 1)
    }
    
}


// MARK: - TableView

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuCell
        
        menuCell.setDataForCell(indexPath: indexPath, menuItems: menuItems)
        
        menuCell.cellDelegate = self
        menuCell.index = indexPath
        
        return menuCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
}


// MARK: - Protocol

extension MenuViewController: MenuViewProtocol {
    
    func setMenuItems(items: [MenuItem]) {
        menuItems.append(contentsOf: items)
    }
    
}


// MARK: - Cell buttons delegate

extension MenuViewController: tableViewClickButtonProtocol {
    
    
    func clickAddButton(index: Int, senderCell: MenuCell) {
        senderCell.showCount()
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        senderCell.countLabel.text = String(countInCart)
    }
    
    
    func minusFunc(index: Int, senderCell: MenuCell) {
        
        if Korzina.shared.isAddedToCart(item: menuItems[index]) {
            let countInCart = Korzina.shared.removeFromCart(item: menuItems[index])
            if countInCart > 0 {
                senderCell.countLabel.text = String(countInCart)
            } else {
                senderCell.hideCount()
            }
        }
    }
    
    
    func plusFunc(index: Int, senderCell: MenuCell) {
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        senderCell.countLabel.text = String(countInCart)
    }
    
}

