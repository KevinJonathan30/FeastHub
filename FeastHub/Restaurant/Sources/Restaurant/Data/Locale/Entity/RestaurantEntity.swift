//
//  RestaurantEntity.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation
import RealmSwift

public class RestaurantEntity: Object {
    @Persisted var id: String?
    @Persisted var name: String?
    @Persisted var desc: String?
    @Persisted var pictureId: String?
    @Persisted var city: String?
    @Persisted var rating: Double = 0.0
    @Persisted var address: String?
    @Persisted var categories: List<CategoryEntity>
    @Persisted var menus: MenuEntity?
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
