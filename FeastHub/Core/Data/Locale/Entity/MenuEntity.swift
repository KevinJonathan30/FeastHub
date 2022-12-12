//
//  MenuEntity.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation
import RealmSwift

class MenuEntity: Object {
    @Persisted var foods: List<FoodEntity>
    @Persisted var drinks: List<DrinkEntity>
}

class FoodEntity: Object {
    @Persisted var name: String?
}

class DrinkEntity: Object {
    @Persisted var name: String?
}
