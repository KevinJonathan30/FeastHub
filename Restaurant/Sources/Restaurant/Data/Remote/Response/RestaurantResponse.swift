//
//  RestaurantResponse.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public struct RestaurantResponse: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let pictureId: String?
    let city: String?
    let rating: Double?
    let address: String?
    let categories: [CategoryResponse]?
    let menus: MenuResponse?
    let customerReviews: [ReviewResponse]?
}
