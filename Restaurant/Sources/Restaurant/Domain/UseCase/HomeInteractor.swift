//
//  HomeInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

public protocol HomeUseCase {
    func getList() -> AnyPublisher<[RestaurantModel], Error>
    func searchList(by query: String) -> AnyPublisher<[RestaurantModel], Error>
}

public class HomeInteractor: HomeUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    public init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getList() -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getList()
    }
    
    public func searchList(by query: String) -> AnyPublisher<[RestaurantModel], Error> {
        return repository.searchList(by: query)
    }
}
