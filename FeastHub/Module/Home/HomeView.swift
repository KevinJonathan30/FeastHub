//
//  HomeView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import CorePackage

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack {
            switch presenter.viewState {
            case .loading:
                loadingIndicator()
            case .fail:
                errorIndicator()
            case .empty:
                emptyRestaurants()
            case .loaded:
                content()
            }
        }
        .navigationBarTitle("home_title".localized())
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                self.presenter.linkBuilderToProfile {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.blue)
                }.buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear {
            if self.presenter.restaurants.isEmpty {
                self.presenter.getRestaurantList()
            }
        }
        .searchable(text: self.$presenter.searchQuery)
        .refreshable {
            guard self.presenter.searchQuery.isEmpty else { return }
            self.presenter.getRestaurantList()
        }
    }
}

// MARK: ViewBuilder

extension HomeView {
    @ViewBuilder
    func loadingIndicator() -> some View {
        VStack {
            Text("loading".localized())
            ProgressView()
        }
    }
    
    @ViewBuilder
    func errorIndicator() -> some View {
        CustomEmptyView(
            image: "assetListNotFound",
            title: presenter.errorMessage
        )
    }
    
    @ViewBuilder
    func emptyRestaurants() -> some View {
        if self.presenter.searchQuery.isEmpty {
            CustomEmptyView(
                image: "assetEmpty",
                title: "restaurant_empty".localized()
            )
        } else {
            CustomEmptyView(
                image: "assetSearchNotFound",
                title: "no_search_result".localized()
            )
        }
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(
                    self.presenter.restaurants,
                    id: \.id
                ) { restaurant in
                    ZStack {
                        self.presenter.linkBuilder(for: restaurant) {
                            RestaurantCard(restaurant: restaurant)
                                .contextMenu {
                                    self.presenter.linkBuilder(for: restaurant) {
                                        Button {} label: {
                                            Label("view_detail".localized(), systemImage: "cup.and.saucer.fill")
                                        }
                                    }
                                }
                        }.buttonStyle(PlainButtonStyle())
                    }.padding(8)
                }
            }
        }
    }
}
