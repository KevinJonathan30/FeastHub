//
//  FavoriteInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getFavoriteRestaurants()
    }
}
