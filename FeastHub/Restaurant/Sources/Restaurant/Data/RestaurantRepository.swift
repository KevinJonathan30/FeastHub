//
//  RestaurantRepository.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

public protocol RestaurantRepositoryProtocol {
    func getList() -> AnyPublisher<[RestaurantModel], Error>
    func getDetail(by id: String) -> AnyPublisher<RestaurantModel, Error>
    func searchList(by query: String) -> AnyPublisher<[RestaurantModel], Error>
    func postReview(by id: String, name: String, review: String) -> AnyPublisher<[ReviewModel], Error>
    func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error>
    func getRestaurantIsFavorite(withId id: String) -> AnyPublisher<Bool, Error>
    func addFavoriteRestaurant(from restaurant: RestaurantModel) -> AnyPublisher<Bool, Error>
    func deleteFavoriteRestaurant(withId id: String) -> AnyPublisher<Bool, Error>
}

public class RestaurantRepository: NSObject {
    public typealias RestaurantInstance = (LocaleDataSource, RemoteDataSource) -> RestaurantRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    public static let sharedInstance: RestaurantInstance = { localeRepo, remoteRepo in
        return RestaurantRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension RestaurantRepository: RestaurantRepositoryProtocol {
    public func getList() -> AnyPublisher<[RestaurantModel], Error> {
        return self.remote.getList()
            .map { RestaurantMapper.mapRestaurantResponseListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getDetail(by id: String) -> AnyPublisher<RestaurantModel, Error> {
        return self.remote.getDetail(by: id)
            .map { RestaurantMapper.mapRestaurantResponseToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func searchList(
        by query: String
    ) -> AnyPublisher<[RestaurantModel], Error> {
        return self.remote.searchList(by: query)
            .map { RestaurantMapper.mapRestaurantResponseListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func postReview(
        by id: String,
        name: String,
        review: String
    ) -> AnyPublisher<[ReviewModel], Error> {
        return self.remote.postReview(by: id, name: name, review: review)
            .map { ReviewMapper.mapReviewResponseListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return self.locale.getFavoriteRestaurants()
            .map { RestaurantMapper.mapRestaurantEntityListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func getRestaurantIsFavorite(withId id: String) -> AnyPublisher<Bool, Error> {
        return self.locale.getRestaurantIsFavorite(withId: id)
            .eraseToAnyPublisher()
    }
    
    public func addFavoriteRestaurant(
        from restaurant: RestaurantModel
    ) -> AnyPublisher<Bool, Error> {
        return self.locale.addFavoriteRestaurant(
            from: RestaurantMapper.mapRestaurantModelToEntity(input: restaurant)
        ).eraseToAnyPublisher()
    }
    
    public func deleteFavoriteRestaurant(
        withId id: String
    ) -> AnyPublisher<Bool, Error> {
        return self.locale.deleteFavoriteRestaurant(withId: id)
            .eraseToAnyPublisher()
    }
}
