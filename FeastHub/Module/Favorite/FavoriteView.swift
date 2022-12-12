//
//  FavoriteView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            switch presenter.viewState {
            case .loading:
                loadingIndicator()
            case .fail:
                errorIndicator()
            case .empty:
                emptyFavorites()
            case .loaded:
                content()
            }
        }.onAppear {
            self.presenter.getFavoriteRestaurants()
        }.navigationBarTitle("Favorite")
    }
    
}

extension FavoriteView {
    @ViewBuilder
    func loadingIndicator() -> some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    @ViewBuilder
    func errorIndicator() -> some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    @ViewBuilder
    func emptyFavorites() -> some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Your favorite is empty"
        ).offset(y: 80)
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            ForEach(
                self.presenter.restaurants,
                id: \.id
            ) { restaurant in
                ZStack {
                    self.presenter.linkBuilder(for: restaurant) {
                        RestaurantCard(restaurant: restaurant)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
