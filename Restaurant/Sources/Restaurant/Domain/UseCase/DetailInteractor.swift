//
//  DetailInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

public protocol DetailUseCase {
    func getDetail(withId id: String) -> AnyPublisher<RestaurantModel, Error>
    func getRestaurantIsFavorite(withId id: String) -> AnyPublisher<Bool, Error>
    func addFavoriteRestaurant(restaurant: RestaurantModel) -> AnyPublisher<Bool, Error>
    func deleteFavoriteRestaurant(withId id: String) -> AnyPublisher<Bool, Error>
    func postReview(withId id: String, name: String, review: String) -> AnyPublisher<[ReviewModel], Error>
}

public class DetailInteractor: DetailUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    public init(
        repository: RestaurantRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func getDetail(withId id: String) -> AnyPublisher<RestaurantModel, Error> {
        return repository.getDetail(by: id)
    }
    
    public func getRestaurantIsFavorite(withId id: String) -> AnyPublisher<Bool, Error> {
        return repository.getRestaurantIsFavorite(withId: id)
    }
    
    public func addFavoriteRestaurant(restaurant: RestaurantModel) -> AnyPublisher<Bool, Error> {
        return repository.addFavoriteRestaurant(from: restaurant)
    }
    
    public func deleteFavoriteRestaurant(withId id: String) -> AnyPublisher<Bool, Error> {
        return repository.deleteFavoriteRestaurant(withId: id)
    }
    
    public func postReview(withId id: String, name: String, review: String) -> AnyPublisher<[ReviewModel], Error> {
        return repository.postReview(by: id, name: name, review: review)
    }
}
