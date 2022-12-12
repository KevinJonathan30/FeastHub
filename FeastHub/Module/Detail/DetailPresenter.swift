//
//  DetailPresenter.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    
    @Published var restaurant: RestaurantModel
    @Published var errorMessage: String = ""
    @Published var viewState: ViewState = .loading
    
    init(detailUseCase: DetailUseCase, restaurant: RestaurantModel) {
        self.detailUseCase = detailUseCase
        self.restaurant = restaurant
    }
    
    func getRestaurantDetail() {
        viewState = .loading
        detailUseCase.getDetail(id: restaurant.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.viewState = .fail
                case .finished:
                    self.viewState = .loaded
                }
            }, receiveValue: { restaurant in
                self.restaurant = restaurant
            })
            .store(in: &cancellables)
    }
}
