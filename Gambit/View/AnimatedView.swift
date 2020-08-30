//
//  AnimatedView.swift
//  Gambit
//
//  Created by Рамазан on 20.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit

extension MenuViewController {
    
    
    func createAnimatedView() {
        animatedView.layer.cornerRadius = 12
        animatedView.backgroundColor = .darkGray
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tabBarController?.tabBar.addSubview(animatedView)
        
        animatedView.leadingAnchor.constraint(equalTo: (self.tabBarController?.tabBar.leadingAnchor)!, constant: 20).isActive = true
        animatedView.trailingAnchor.constraint(equalTo: (self.tabBarController?.tabBar.trailingAnchor)!, constant: -20).isActive = true
        animatedView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        constAnimView = animatedView.bottomAnchor.constraint(equalTo: (self.tabBarController?.tabBar.bottomAnchor)!, constant: 60)
        constAnimView?.isActive = true
        
        animatedView.addSubview(itemsInCartLabel)
        animatedView.addSubview(allPriceLabel)
        animatedView.addSubview(korzinaLabel)
        
        itemsInCartLabel.text = ""
        itemsInCartLabel.textColor = .white
        itemsInCartLabel.font = .boldSystemFont(ofSize: 18)
        itemsInCartLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsInCartLabel.centerYAnchor.constraint(equalTo: animatedView.centerYAnchor).isActive = true
        itemsInCartLabel.leadingAnchor.constraint(equalTo: animatedView.leadingAnchor, constant: 16).isActive = true
        
        allPriceLabel.text = ""
        allPriceLabel.textColor = .white
        allPriceLabel.font = .boldSystemFont(ofSize: 18)
        allPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        allPriceLabel.centerYAnchor.constraint(equalTo: animatedView.centerYAnchor).isActive = true
        allPriceLabel.trailingAnchor.constraint(equalTo: animatedView.trailingAnchor, constant: -16).isActive = true
        
        korzinaLabel.text = "Корзина"
        korzinaLabel.textColor = .white
        korzinaLabel.font = .boldSystemFont(ofSize: 20)
        korzinaLabel.translatesAutoresizingMaskIntoConstraints = false
        korzinaLabel.centerYAnchor.constraint(equalTo: animatedView.centerYAnchor).isActive = true
        korzinaLabel.centerXAnchor.constraint(equalTo: animatedView.centerXAnchor).isActive = true
        
        countAllCart()
    }
    
}
