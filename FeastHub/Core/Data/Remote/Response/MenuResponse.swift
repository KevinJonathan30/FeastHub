//
//  MenuResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

struct MenuResponse: Decodable {
    let foods: [FoodResponse]?
    let drinks: [DrinkResponse]?
}

struct FoodResponse: Decodable {
    let name: String?
}

struct DrinkResponse: Decodable {
    let name: String?
}
