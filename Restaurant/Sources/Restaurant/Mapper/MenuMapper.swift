//
//  MenuMapper.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation
import RealmSwift

public class MenuMapper {
    
    // MARK: Response to Model
    
    public static func mapMenuResponseToModel(
        input menuResponseList: MenuResponse?
    ) -> MenuModel {
        var menuModel = MenuModel()
        menuModel.foods = mapFoodResponseListToModelList(
            input: menuResponseList?.foods ?? []
        )
        menuModel.drinks = mapDrinkResponseListToModelList(
            input: menuResponseList?.drinks ?? []
        )
        return menuModel
    }
    
    public static func mapFoodResponseListToModelList(
        input foodResponseList: [FoodResponse]
    ) -> [FoodModel] {
        return foodResponseList.map { result in
            var foodModel = FoodModel()
            foodModel.name = result.name ?? ""
            return foodModel
        }
    }
    
    public static func mapDrinkResponseListToModelList(
        input drinkResponseList: [DrinkResponse]
    ) -> [DrinkModel] {
        return drinkResponseList.map { result in
            var drinkModel = DrinkModel()
            drinkModel.name = result.name ?? ""
            return drinkModel
        }
    }
    
    // MARK: Entity to Model
    
    public static func mapMenuEntityToModel(
        input menuEntity: MenuEntity?
    ) -> MenuModel {
        var menuModel = MenuModel()
        menuModel.foods = mapFoodEntityListToModelList(
            input: menuEntity?.foods ?? RealmSwift.List<FoodEntity>()
        )
        menuModel.drinks = mapDrinkEntityListToModelList(
            input: menuEntity?.drinks ?? RealmSwift.List<DrinkEntity>()
        )
        return menuModel
    }
    
    public static func mapFoodEntityListToModelList(
        input foodEntities: RealmSwift.List<FoodEntity>
    ) -> [FoodModel] {
        return foodEntities.map { result in
            var foodModel = FoodModel()
            foodModel.name = result.name ?? ""
            return foodModel
        }
    }
    
    public static func mapDrinkEntityListToModelList(
        input drinkEntities: RealmSwift.List<DrinkEntity>
    ) -> [DrinkModel] {
        return drinkEntities.map { result in
            var drinkModel = DrinkModel()
            drinkModel.name = result.name ?? ""
            return drinkModel
        }
    }
    
    // MARK: Model to Entity
    
    public static func mapMenuModelToEntity(
        input menuModel: MenuModel
    ) -> MenuEntity {
        let menuEntity = MenuEntity()
        menuEntity.foods = mapFoodModelListToEntityList(input: menuModel.foods)
        menuEntity.drinks = mapDrinkModelListToEntityList(input: menuModel.drinks)
        
        return menuEntity
    }
    
    public static func mapFoodModelListToEntityList(
        input foodModelList: [FoodModel]
    ) -> RealmSwift.List<FoodEntity> {
        let foodEntityList = List<FoodEntity>()
        
        for food in foodModelList {
            let foodEntity = FoodEntity()
            foodEntity.name = food.name
            foodEntityList.append(foodEntity)
        }
        
        return foodEntityList
    }
    
    public static func mapDrinkModelListToEntityList(
        input drinkModelList: [DrinkModel]
    ) -> RealmSwift.List<DrinkEntity> {
        let drinkEntityList = List<DrinkEntity>()
        
        for drink in drinkModelList {
            let drinkEntity = DrinkEntity()
            drinkEntity.name = drink.name
            drinkEntityList.append(drinkEntity)
        }
        
        return drinkEntityList
    }
}
