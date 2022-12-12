//
//  DetailInteractor.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getDetail(id: String) -> AnyPublisher<RestaurantModel, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: RestaurantRepositoryProtocol
    
    required init(
        repository: RestaurantRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func getDetail(id: String) -> AnyPublisher<RestaurantModel, Error> {
        return repository.getDetail(by: id)
    }
}
