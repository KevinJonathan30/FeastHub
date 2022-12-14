//
//  RestaurantModel.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

struct RestaurantModel: Equatable, Identifiable {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var pictureId: String = ""
    var city: String = ""
    var rating: Double = 0.0
    var address: String = ""
    var categories: [CategoryModel] = []
    var menus: MenuModel = MenuModel()
    var customerReviews: [ReviewModel] = []
    
    static func == (lhs: RestaurantModel, rhs: RestaurantModel) -> Bool {
        return lhs.id == rhs.id
    }
}
