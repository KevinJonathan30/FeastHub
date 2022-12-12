//
//  RestaurantDetailResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

struct RestaurantDetailResponse: Decodable {
    let error: Bool?
    let message: String?
    let restaurant: RestaurantResponse?
}
