//
//  UserDefaults.swift
//  Gambit
//
//  Created by Рамазан on 20.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation


struct KorzinaModel: Codable {
    var menuItem: MenuItem
    var countInCart: Int
}



final class Korzina {
    
    static let shared = Korzina()
    
    private let key = "korzina_gambit"
    private var menu: [KorzinaModel] = []
    
    private let favKey = "favorite_gambit"
    private var favItems: [MenuItem] = []
    
    private init() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let menuFromDataBase = try? JSONDecoder().decode([KorzinaModel].self, from: data),
            
            let favData = UserDefaults.standard.data(forKey: favKey),
            let favFromDB = try? JSONDecoder().decode([MenuItem].self, from: favData)
        else { return }
        
        menu.append(contentsOf: menuFromDataBase)
        favItems.append(contentsOf: favFromDB)
    }
    
    
    // MARK: - Public func
    
    // Проверка на нахождение в ЮзерДефаултс
    func isAddedToCart(item: MenuItem?) -> Bool {
        if let _ = menu.firstIndex(where: { $0.menuItem.id == item?.id}) {
            return true
        } else {
            return false
        }
    }
    
    
    // Проверка и добавление элемента или увеличение уличества
    func addToCart(item: MenuItem) -> Int {
        if let index = menu.firstIndex(where: { $0.menuItem.id == item.id}) {
            menu[index].countInCart += 1
            synchronize()
            return menu[index].countInCart
        } else {
            let newItemKorzina = KorzinaModel(menuItem: item, countInCart: 1)
            menu.append(newItemKorzina)
            synchronize()
            return 1
        }
    }
    
    
    // Проверка количества
    func checkCount(item: MenuItem) -> Int {
        if let index = menu.firstIndex(where: { $0.menuItem.id == item.id}) {
            let countInCart = menu[index].countInCart
            return countInCart
        } else {
            return 0
        }
    }
    
    
    // Проверка и удаление записи
    func removeFromCart(item: MenuItem) -> Int {
        if let index = menu.firstIndex(where: { $0.menuItem.id == item.id}) {
            if menu[index].countInCart > 1 {
                menu[index].countInCart -= 1
                synchronize()
                return menu[index].countInCart
            } else {
                menu.remove(at: index)
                synchronize()
                return 0
            }
        } else {
            return 0
        }
    }
    
    
    // Очистка
    func clear() {
        menu.removeAll()
        synchronize()
    }
    
    
    // Обновление данных
    private func synchronize() {
        guard
            let menu = try? JSONEncoder().encode(menu),
            let favItems = try? JSONEncoder().encode(favItems)
        else { return }
        
        UserDefaults.standard.set(menu, forKey: key)
        UserDefaults.standard.set(favItems, forKey: favKey)
    }
    
    
    // Подсчет общей суммы корзины
    func countAllPrice() -> Int {
        var allPrice = 0
        for item in menu {
            let count = item.countInCart
            let price = item.menuItem.price ?? 0
            allPrice += count * price
        }
        return allPrice
    }
    
    func countItems() -> Int {
        return menu.count
    }
    
    
    
    // MARK: - favorite
    
    // Проверка на нахождение в избранном
    func isFavorite(item: MenuItem) -> Bool {
        if let _ = favItems.firstIndex(where: { $0.id == item.id}) {
            return true
        } else {
            return false
        }
    }
    
    
    // Добавление и удаление из избранного
    func addOrRemoveFavorite(item: MenuItem) -> Bool {
        if let index = favItems.firstIndex(where: { $0.id == item.id}) {
            favItems.remove(at: index)
            
            //обновление данных юзерфалс
            synchronize()
            return false
        } else {
            favItems.append(item)
            synchronize()
            return true
        }
    }
    
}
