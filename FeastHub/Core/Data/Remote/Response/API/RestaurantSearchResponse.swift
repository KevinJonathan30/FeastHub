//
//  RestaurantSearchResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

struct RestaurantSearchResponse: Decodable {
    let error: Bool?
    let founded: Int?
    let restaurants: [RestaurantResponse]?
}
