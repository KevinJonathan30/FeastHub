//
//  MenuEntity.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation
import RealmSwift

public class MenuEntity: Object {
    @Persisted var foods: List<FoodEntity>
    @Persisted var drinks: List<DrinkEntity>
}

public class FoodEntity: Object {
    @Persisted var name: String?
}

public class DrinkEntity: Object {
    @Persisted var name: String?
}
