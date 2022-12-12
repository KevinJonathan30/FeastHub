//
//  RestaurantMapper.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import Foundation

final class RestaurantMapper {
    
    // MARK: Response to Model
    
    static func mapRestaurantResponseToModel(
        input restaurantResponse: RestaurantResponse
    ) -> RestaurantModel {
        var restaurantModel = RestaurantModel()
        restaurantModel.id = restaurantResponse.id ?? ""
        restaurantModel.name = restaurantResponse.name ?? ""
        restaurantModel.address = restaurantResponse.address ?? ""
        restaurantModel.city = restaurantResponse.city ?? ""
        restaurantModel.description = restaurantResponse.description ?? ""
        restaurantModel.pictureId = restaurantResponse.pictureId ?? ""
        restaurantModel.rating = restaurantResponse.rating ?? 0.0
        restaurantModel.categories = CategoryMapper.mapCategoryResponseListToModelList(
            input: restaurantResponse.categories ?? []
        )
        restaurantModel.menus = MenuMapper.mapMenuResponseToModel(
            input: restaurantResponse.menus
        )
        restaurantModel.customerReviews = ReviewMapper.mapReviewResponseListToModelList(
            input: restaurantResponse.customerReviews ?? []
        )
        return restaurantModel
    }
    
    static func mapRestaurantResponseListToModelList(
        input restaurantResponseList: [RestaurantResponse]
    ) -> [RestaurantModel] {
        return restaurantResponseList.map { result in
            return RestaurantMapper.mapRestaurantResponseToModel(input: result)
        }
    }
    
    // MARK: Entity to Model
    
    static func mapRestaurantEntityListToModelList(
        input restaurantEntities: [RestaurantEntity]
    ) -> [RestaurantModel] {
        return restaurantEntities.map { result in
            return RestaurantModel(
                id: result.id ?? "",
                name: result.name ?? "",
                description: result.desc ?? "",
                pictureId: result.pictureId ?? "",
                city: result.city ?? "",
                rating: result.rating,
                address: result.address ?? "",
                categories: CategoryMapper.mapCategoryEntityListToModelList(
                    input: result.categories
                ),
                menus: MenuMapper.mapMenuEntityToModel(
                    input: result.menus
                ),
                customerReviews: []
            )
        }
    }
    
    // MARK: Model to Entity
    
    static func mapRestaurantModelToEntity(
        input restaurantModel: RestaurantModel
    ) -> RestaurantEntity {
        let restaurantEntity = RestaurantEntity()
        restaurantEntity.id = restaurantModel.id
        restaurantEntity.name = restaurantModel.name
        restaurantEntity.desc = restaurantModel.description
        restaurantEntity.pictureId = restaurantModel.pictureId
        restaurantEntity.city = restaurantModel.city
        restaurantEntity.rating = restaurantModel.rating
        restaurantEntity.address = restaurantModel.address
        restaurantEntity.categories = CategoryMapper.mapCategoryModelListToEntityList(
            input: restaurantModel.categories
        )
        restaurantEntity.menus = MenuMapper.mapMenuModelToEntity(
            input: restaurantModel.menus
        )
        return restaurantEntity
    }
}
