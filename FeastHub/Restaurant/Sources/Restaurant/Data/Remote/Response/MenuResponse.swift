//
//  MenuResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public struct MenuResponse: Decodable {
    let foods: [FoodResponse]?
    let drinks: [DrinkResponse]?
}

public struct FoodResponse: Decodable {
    let name: String?
}

public struct DrinkResponse: Decodable {
    let name: String?
}
