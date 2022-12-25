//
//  RestaurantListResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public struct RestaurantListResponse: Decodable {
    let error: Bool?
    let message: String?
    let count: Int?
    let restaurants: [RestaurantResponse]?
}
