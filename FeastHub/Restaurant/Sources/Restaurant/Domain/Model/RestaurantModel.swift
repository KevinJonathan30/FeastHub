//
//  RestaurantModel.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation

public struct RestaurantModel: Equatable, Identifiable {
    public var id: String = ""
    public var name: String = ""
    public var description: String = ""
    public var pictureId: String = ""
    public var city: String = ""
    public var rating: Double = 0.0
    public var address: String = ""
    public var categories: [CategoryModel] = []
    public var menus: MenuModel = MenuModel()
    public var customerReviews: [ReviewModel] = []
    
    public static func == (lhs: RestaurantModel, rhs: RestaurantModel) -> Bool {
        return lhs.id == rhs.id
    }
}
