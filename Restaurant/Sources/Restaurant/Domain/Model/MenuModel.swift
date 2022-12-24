//
//  MenuModel.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation

public struct MenuModel: Equatable, Identifiable {
    public var id: UUID = UUID()
    public var foods: [FoodModel] = []
    public var drinks: [DrinkModel] = []
    
    public static func == (lhs: MenuModel, rhs: MenuModel) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct FoodModel: Equatable, Identifiable {
    public var id: UUID = UUID()
    public var name: String = ""
}

public struct DrinkModel: Equatable, Identifiable {
    public var id: UUID = UUID()
    public var name: String = ""
}
