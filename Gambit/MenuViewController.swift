//
//  ViewController.swift
//  Gambit
//
//  Created by Рамазан on 17.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let menuTableView = UITableView()
    let cellID = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        createMenuTableView() 
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
        
        menuTableView.backgroundColor = .green
    }
    
}



// MARK: - TableView

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
