//
//  RestaurantRepository.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

protocol RestaurantRepositoryProtocol {
    func getList() -> AnyPublisher<[RestaurantModel], Error>
    func getDetail(by id: String) -> AnyPublisher<RestaurantModel, Error>
    func searchList(by query: String) -> AnyPublisher<[RestaurantModel], Error>
    func postReview(by id: String, name: String, review: String) -> AnyPublisher<Bool, Error>
    func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error>
    func addFavoriteRestaurant(from restaurant: RestaurantModel) -> AnyPublisher<Bool, Error>
    func deleteFavoriteRestaurant(withId id: String) -> AnyPublisher<Bool, Error>
}

final class RestaurantRepository: NSObject {
    typealias RestaurantInstance = (LocaleDataSource, RemoteDataSource) -> RestaurantRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: RestaurantInstance = { localeRepo, remoteRepo in
        return RestaurantRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension RestaurantRepository: RestaurantRepositoryProtocol {
    func getList() -> AnyPublisher<[RestaurantModel], Error> {
        return self.remote.getList()
            .map { RestaurantMapper.mapRestaurantResponseListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getDetail(by id: String) -> AnyPublisher<RestaurantModel, Error> {
        return self.remote.getDetail(by: id)
            .map { RestaurantMapper.mapRestaurantResponseToModel(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func searchList(
        by query: String
    ) -> AnyPublisher<[RestaurantModel], Error> {
        return self.remote.searchList(by: query)
            .map { RestaurantMapper.mapRestaurantResponseListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func postReview(
        by id: String,
        name: String,
        review: String
    ) -> AnyPublisher<Bool, Error> {
        return self.remote.postReview(by: id, name: name, review: review)
            .eraseToAnyPublisher()
    }
    
    func getFavoriteRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return self.locale.getFavoriteRestaurants()
            .map { RestaurantMapper.mapRestaurantEntityListToModelList(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func addFavoriteRestaurant(
        from restaurant: RestaurantModel
    ) -> AnyPublisher<Bool, Error> {
        return self.locale.addFavoriteRestaurant(
            from: RestaurantMapper.mapRestaurantModelToEntity(input: restaurant)
        ).eraseToAnyPublisher()
    }
    
    func deleteFavoriteRestaurant(
        withId id: String
    ) -> AnyPublisher<Bool, Error> {
        return self.locale.deleteFavoriteRestaurant(withId: id)
            .eraseToAnyPublisher()
    }
}
