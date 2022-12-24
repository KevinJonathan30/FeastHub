//
//  FavoriteInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

public protocol FavoriteUseCase {
    func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error>
}

public class FavoriteInteractor: FavoriteUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    public init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getFavoriteRestaurants()
    }
}
