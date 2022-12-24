//
//  HomePresenter.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import Combine
import Restaurant

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var viewState: ViewState = .loading
    @Published var searchQuery: String = ""
    var allRestaurants: [RestaurantModel] = []
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        self.initObserver()
    }
    
    deinit {
        self.cancellables.removeAll()
    }
    
    func initObserver() {
        initSearchRestaurantObserver()
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
            }, receiveValue: { [weak self] restaurants in
                guard let self = self else { return }
                withAnimation(.spring()) {
                    self.restaurants = restaurants
                    self.allRestaurants = restaurants
                    
                    if restaurants.isEmpty {
                        self.viewState = .empty
                    } else {
                        self.viewState = .loaded
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func initSearchRestaurantObserver() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchQuery in
                guard let self = self,
                      !searchQuery.isEmpty else {
                    withAnimation(.spring()) {
                        self?.restaurants = self?.allRestaurants ?? []
                        self?.viewState = .loaded
                    }
                    return
                }
                self.getSearchList(searchQuery: searchQuery)
            }
            .store(in: &cancellables)
    }
    
    func getSearchList(searchQuery: String) {
        self.viewState = .loading
        self.homeUseCase.searchList(by: searchQuery)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.viewState = .fail
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] restaurants in
                guard let self = self else { return }
                withAnimation(.spring()) {
                    guard !searchQuery.isEmpty else {
                        withAnimation(.spring()) {
                            self.restaurants = self.allRestaurants
                        }
                        return
                    }
                    
                    self.restaurants = restaurants
                    
                    if restaurants.isEmpty {
                        self.viewState = .empty
                    } else {
                        self.viewState = .loaded
                    }
                }
            })
            .store(in: &self.cancellables)
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: restaurant)) { content() }
    }
    
    func linkBuilderToProfile<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeProfileView) { content() }
    }
}
