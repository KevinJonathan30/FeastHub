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
    @Published var isFavorite: Bool = false
    
    init(detailUseCase: DetailUseCase, restaurant: RestaurantModel) {
        self.detailUseCase = detailUseCase
        self.restaurant = restaurant
    }
    
    deinit {
        self.cancellables.removeAll()
    }
    
    func getRestaurantDetail() {
        viewState = .loading
        detailUseCase.getDetail(withId: restaurant.id)
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
    
    func getRestaurantIsFavorite() {
        detailUseCase.getRestaurantIsFavorite(withId: self.restaurant.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { isFavorite in
                self.isFavorite = isFavorite
            })
            .store(in: &cancellables)
    }
    
    func addFavoriteRestaurant() {
        detailUseCase.addFavoriteRestaurant(restaurant: restaurant)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { isSuccess in
                print(isSuccess)
                self.getRestaurantIsFavorite()
            })
            .store(in: &cancellables)
    }
    
    func deleteFavoriteRestaurant() {
        detailUseCase.deleteFavoriteRestaurant(withId: restaurant.id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { isSuccess in
                print(isSuccess)
                self.getRestaurantIsFavorite()
            })
            .store(in: &cancellables)
    }
}
