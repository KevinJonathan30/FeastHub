//
//  HomeInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getList() -> AnyPublisher<[RestaurantModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    func getList() -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getList()
    }
}
