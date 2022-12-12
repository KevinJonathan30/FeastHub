//
//  HomePresenter.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var viewState: ViewState = .loading
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getRestaurantList() {
        viewState = .loading
        homeUseCase.getList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.viewState = .fail
                case .finished:
                    break
                }
            }, receiveValue: { restaurants in
                withAnimation(.spring()) {
                    self.restaurants = restaurants
                    
                    if restaurants.isEmpty {
                        self.viewState = .empty
                    } else {
                        self.viewState = .loaded
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: restaurant)) { content() }
    }
    
}
