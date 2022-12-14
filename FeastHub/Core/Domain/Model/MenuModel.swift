//
//  MenuModel.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation

struct MenuModel: Equatable, Identifiable {
    var id: UUID = UUID()
    var foods: [FoodModel] = []
    var drinks: [DrinkModel] = []
    
    static func == (lhs: MenuModel, rhs: MenuModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct FoodModel: Equatable, Identifiable {
    var id: UUID = UUID()
    var name: String = ""
}

struct DrinkModel: Equatable, Identifiable {
    var id: UUID = UUID()
    var name: String = ""
}
