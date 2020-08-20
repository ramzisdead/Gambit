//
//  MenuCell.swift
//  Gambit
//
//  Created by Рамазан on 18.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import UIKit


protocol tableViewClickButtonProtocol {
    func clickAddButton(index: Int, senderCell: MenuCell)
    func plusFunc(index: Int, senderCell: MenuCell)
    func minusFunc(index: Int, senderCell: MenuCell)
}


class MenuCell: UITableViewCell {
    
    var cellDelegate: tableViewClickButtonProtocol?
    var index: IndexPath?
    
    
    // MARK: - Views
    
    let itemImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        //img.backgroundColor = .darkGray
        //img.image = UIImage(named: "TestImage")
        return img
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 3
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = #colorLiteral(red: 0.9717701077, green: 0, blue: 0.5715600848, alpha: 1)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0.9717701077, green: 0, blue: 0.5715600848, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0.9717701077, green: 0, blue: 0.5715600848, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - My functions
    
    func setDataForCell(indexPath: IndexPath, menuItems: [MenuItem]) {
        let imageURL = menuItems[indexPath.row].image ?? ""
        let price = menuItems[indexPath.row].price
        
        self.titleLabel.text = menuItems[indexPath.row].name
        self.priceLabel.text = String(price ?? 0) + " ₽"
        self.itemImage.sd_setImage(with: URL(string: imageURL), completed: nil)
        
        // Нужна проверка на плюс
        if Korzina.shared.isAddedToCart(item: menuItems[indexPath.row]) {
            self.showCount()
            let countInCart = Korzina.shared.checkCount(item: menuItems[indexPath.row])
            self.countLabel.text = String(countInCart)
        } else {
            self.hideCount()
        }
    }
    
    
    @objc func clickAddToCart(_ sender: UIButton) {
        cellDelegate?.clickAddButton(index: index?.row ?? 0, senderCell: self)
    }

    
    @objc func plusFunc(_ sender: UIButton) {
        cellDelegate?.plusFunc(index: index?.row ?? 0, senderCell: self)
        
    }
    
    
    @objc func minusFunc(_ sender: UIButton) {
        cellDelegate?.minusFunc(index: index?.row ?? 0, senderCell: self)
    }
    
    
    func hideCount() {
        self.addToCartButton.isHidden = false
        self.plusButton.isHidden = true
        self.countLabel.isHidden = true
        self.minusButton.isHidden = true
        //self.countLabel.text = ""
    }
    
    
    func showCount() {
        self.addToCartButton.isHidden = true
        self.plusButton.isHidden = false
        self.minusButton.isHidden = false
        self.countLabel.isHidden = false
    }
    
    
    // MARK: - Default functions

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавляем элементы на Вью
        self.contentView.addSubview(itemImage)
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(priceLabel)
        self.containerView.addSubview(addToCartButton)
        
        self.containerView.addSubview(plusButton)
        self.containerView.addSubview(minusButton)
        self.containerView.addSubview(countLabel)
        
        // Чтобы работала функция у кнопки
        self.addToCartButton.addTarget(self, action: #selector(clickAddToCart(_:)), for: .touchUpInside)
        self.minusButton.addTarget(self, action: #selector(minusFunc(_:)), for: .touchUpInside)
        self.plusButton.addTarget(self, action: #selector(plusFunc(_:)), for: .touchUpInside)
        
        // Image constraints
        itemImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        itemImage.widthAnchor.constraint(equalToConstant: 148).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 148).isActive = true
        
        // ContainerView constraints - Center Y
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        // Left
        containerView.leadingAnchor.constraint(equalTo: self.itemImage.trailingAnchor, constant: 24).isActive = true
        // Right
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        // Height
        containerView.heightAnchor.constraint(equalToConstant: 148).isActive = true
        
        // Price label constraints
        priceLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 0).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 64).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Title label constraints
        titleLabel.bottomAnchor.constraint(equalTo: self.priceLabel.topAnchor, constant: -32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 0).isActive = true
        
        // AddToCart button constraints
        addToCartButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 0).isActive = true
        addToCartButton.widthAnchor.constraint(equalToConstant: 96).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Plus button constraints
        plusButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: 0).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Count label constraints
        countLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: self.plusButton.leadingAnchor, constant: 0).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // Minus button constraints
        minusButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -20).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: self.countLabel.leadingAnchor, constant: 0).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
