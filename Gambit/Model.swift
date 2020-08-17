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
    var id: String
    var name: String?
    var image: String?
    var price: Int?
    var description: String?
    var isFavorite: Bool?
    var nutritionFacts: NutritionFacts?
    

    // Вес и БЖУ
    struct NutritionFacts: Codable {
        var weight: Int?
        var calories: Int?
        var protein: Int?
        var fat: Int?
        var carbohydrates: Int?
    }

}
