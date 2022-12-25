//
//  CategoryEntity.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import RealmSwift

public class CategoryEntity: Object {
    @Persisted var name: String?
}
