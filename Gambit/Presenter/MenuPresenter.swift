//
//  Presenter.swift
//  Gambit
//
//  Created by Рамазан on 18.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation
import Alamofire



protocol MenuPresenterProtocol {
    var itemsArray: [MenuItem]? {get set}
    
    func getMenuItems()
    
    init(view: MenuViewProtocol)
}



class MenuPresenter: MenuPresenterProtocol {
    
    // MARK: - init
    
    required init (view: MenuViewProtocol) {
        self.view = view
        getMenuItems()
    }
    
    // MARK: - getItems
    
    var view: MenuViewProtocol?
    
    var itemsArray: [MenuItem]?
    
    func getMenuItems() {
        AF.request("https://api.gambit-app.ru/category/39?page=1").responseData { response in
            switch response.result {
            case .success(let resultJSON):
                let resultArray = try? JSONDecoder().decode([MenuItem].self, from: resultJSON)
                //print(resultArray ?? "resultArray = nil")
                self.itemsArray = resultArray
                //print(self.itemsArray ?? "itemsArray = nil")
                self.view?.setMenuItems(items: self.itemsArray ?? [])
            case .failure(let error):
                print(error)
            }
        }
        print(self.itemsArray ?? "menuItems == nil")
    }
    
    
}
