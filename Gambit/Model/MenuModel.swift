//
//  Model.swift
//  Gambit
//
//  Created by Рамазан on 18.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation


// Позиция меню
struct MenuItem: Codable {
    let id : Int?
    let name : String?
    let image : String?
    let price : Int?
    let description : String?
    let isFavorite : String?
    let nutritionFacts : NutritionFacts?
    
    
    // Вес и БЖУ
    struct NutritionFacts : Codable {
        let weight : Int?
        let calories : Int?
        let protein : Int?
        let fat : Int?
        let carbohydrates : Int?
    }
}
