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
    func showLoading()
    func hideLoading()
}



class MenuViewController: UIViewController {
    
    var constAnimView: NSLayoutConstraint?
    
    let menuTableView = UITableView()
    let animatedView = UIView()
    let itemsInCartLabel = UILabel()
    let allPriceLabel = UILabel()
    let korzinaLabel = UILabel()
    
    let activityIndicator = UIActivityIndicatorView()
    
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
        
        createAnimatedView()
        createActivityIndicator()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimatedView()
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
        menuTableView.separatorStyle = .none
        
        menuTableView.register(MenuCell.self, forCellReuseIdentifier: "Cell")
        menuTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    
    func editNavBar() {
        let titleImage = UIImage(named: "GambitTitle")
        let imageView = UIImageView(image: titleImage)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9717701077, green: 0, blue: 0.5715600848, alpha: 1)
    }
    
    
    func createActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.center = view.center
    }
    
    
    // MARK: - My functions
    
    func countAllCart() {
        let allPrice = Korzina.shared.countAllPrice()
        let itemsInCart = Korzina.shared.countItems()
        
        allPriceLabel.text = String(allPrice) + " ₽"
        itemsInCartLabel.text = String(itemsInCart)
    }
    
    
    func showAnimatedView() {
        countAllCart()
        
        let allPrice = Korzina.shared.countAllPrice()
        if allPrice > 0 {
            constAnimView?.constant = -100
            UIView.animate(withDuration: 0.3) {
                self.tabBarController?.tabBar.layoutIfNeeded()
            }
        } else {
            constAnimView?.constant = animatedView.frame.height
            UIView.animate(withDuration: 0.3) {
                self.tabBarController?.tabBar.layoutIfNeeded()
            }
        }
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let index = indexPath.row
        let isFav = Korzina.shared.isFavorite(item: self.menuItems[index])
        
        let action = UIContextualAction(style: .normal, title: "") { (action, view, complitionHandler) in
            let _ = Korzina.shared.addOrRemoveFavorite(item: self.menuItems[index])
            complitionHandler(true)
        }
        
        action.image = isFav ? UIImage(named: "FavoriteTrue") : UIImage(named: "FavoriteFalse")
        action.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        
        let actions = UISwipeActionsConfiguration(actions: [action])
        return actions

    }
}


// MARK: - Protocol

extension MenuViewController: MenuViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
    func setMenuItems(items: [MenuItem]) {
        menuItems.append(contentsOf: items)
    }
    
}


// MARK: - Cell buttons delegate

extension MenuViewController: cellButtonClickProtocol {
    
    
    func addToCartFunc(index: Int, senderCell: MenuCell) {
        senderCell.showCount()
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        senderCell.countLabel.text = String(countInCart)
        showAnimatedView()
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
        showAnimatedView()
    }
    
    
    func plusFunc(index: Int, senderCell: MenuCell) {
        let countInCart = Korzina.shared.addToCart(item: menuItems[index])
        senderCell.countLabel.text = String(countInCart)
        showAnimatedView()
    }
    
}

