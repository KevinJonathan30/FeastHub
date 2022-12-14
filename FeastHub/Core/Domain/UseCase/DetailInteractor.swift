//
//  DetailInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getDetail(withId id: String) -> AnyPublisher<RestaurantModel, Error>
    func getRestaurantIsFavorite(withId id: String) -> AnyPublisher<Bool, Error>
    func addFavoriteRestaurant(restaurant: RestaurantModel) -> AnyPublisher<Bool, Error>
    func deleteFavoriteRestaurant(withId id: String) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    required init(
        repository: RestaurantRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func getDetail(withId id: String) -> AnyPublisher<RestaurantModel, Error> {
        return repository.getDetail(by: id)
    }
    
    func getRestaurantIsFavorite(withId id: String) -> AnyPublisher<Bool, Error> {
        return repository.getRestaurantIsFavorite(withId: id)
    }
    
    func addFavoriteRestaurant(restaurant: RestaurantModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavoriteRestaurant(from: restaurant)
    }
    
    func deleteFavoriteRestaurant(withId id: String) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavoriteRestaurant(withId: id)
    }
}
