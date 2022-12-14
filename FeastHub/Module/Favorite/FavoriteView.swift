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
        }
        .onAppear {
            self.presenter.getFavoriteRestaurants()
        }
        .navigationBarTitle("Favorite")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                self.presenter.linkBuilderToProfile {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.blue)
                }.buttonStyle(PlainButtonStyle())
            }
        }
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
            image: "assetListNotFound",
            title: presenter.errorMessage
        )
    }
    
    @ViewBuilder
    func emptyFavorites() -> some View {
        CustomEmptyView(
            image: "assetEmpty",
            title: "Your favorite is so empty, try adding something here?"
        )
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
