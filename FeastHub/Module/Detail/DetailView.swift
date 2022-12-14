//
//  DetailView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import CachedAsyncImage
import WrappingHStack

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            switch presenter.viewState {
            case .loading:
                loadingIndicator()
            case .fail:
                errorIndicator()
            default:
                ScrollView(.vertical) {
                    VStack {
                        imageDetail()
                        Spacer()
                        content()
                        Spacer()
                    }.padding()
                }
            }
        }
        .onAppear {
            self.presenter.getRestaurantDetail()
            self.presenter.getRestaurantIsFavorite()
        }
        .navigationBarTitle("Detail", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    if self.presenter.isFavorite {
                        self.presenter.deleteFavoriteRestaurant()
                    } else {
                        self.presenter.addFavoriteRestaurant()
                    }
                } label: {
                    Image(systemName: self.presenter.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

// MARK: ViewBuilder

extension DetailView {
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
    func imageDetail() -> some View {
        CachedAsyncImage(
            url: URL(string: "https://restaurant-api.dicoding.dev/images/medium/\(self.presenter.restaurant.pictureId)")
        ) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFit()
        .padding(-16)
    }
    
    @ViewBuilder
    func mainHeader(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .center) {
            headerTitle(restaurant.name)
                .padding(.bottom, 4)
            
            Text("⭐️ \(String(format: "%.1f", restaurant.rating))")
                .font(.system(size: 14))
            
            HStack {
                ForEach(restaurant.categories) { category in
                    Text(category.name)
                        .font(.caption2)
                        .bold()
                        .padding(4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top)
    }
    
    @ViewBuilder
    func description(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .leading) {
            subheaderTitle("Description")
                .padding(.vertical)
            
            Text(restaurant.description)
                .font(.system(size: 15))
        }.padding(.bottom)
    }
    
    @ViewBuilder
    func menu(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .leading) {
            subheaderTitle("Menu")
                .padding(.vertical)
            
            subheader2Title("Foods")
            
            WrappingHStack(restaurant.menus.foods, id: \.self, lineSpacing: 4) { food in
                Text(food.name)
                    .font(.caption)
                    .padding(4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            
            subheader2Title("Drinks")
            
            WrappingHStack(restaurant.menus.drinks, id: \.self, lineSpacing: 4) { drink in
                Text(drink.name)
                    .font(.caption)
                    .padding(4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
        }.padding(.bottom)
    }
    
    @ViewBuilder
    func location(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .leading) {
            subheaderTitle("Location")
                .padding(.vertical)
            
            HStack {
                Image(systemName: "location.fill")
                
                Text("\(restaurant.address), \(restaurant.city)")
                    .font(.system(size: 15))
            }
        }.padding(.bottom)
    }
    
    @ViewBuilder
    func review(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .leading) {
            subheaderTitle("Customer Reviews")
                .padding(.vertical)
            
            ForEach(restaurant.customerReviews) { review in
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "character.bubble.fill")
                    
                    VStack(alignment: .leading) {
                        Text(review.name)
                            .font(.headline)
                            .bold()
                        
                        Text(review.date)
                            .font(.subheadline)
                        
                        Text(review.review)
                            .font(.body)
                    }
                }
                
                Spacer()
                    .frame(height: 16)
            }
        }
    }
    
    @ViewBuilder
    func headerTitle(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .bold()
    }
    
    @ViewBuilder
    func subheaderTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
    }
    
    @ViewBuilder
    func subheader2Title(_ title: String) -> some View {
        Text(title)
            .font(.subheadline)
    }
    
    @ViewBuilder
    func content() -> some View {
        let restaurant = self.presenter.restaurant
        
        LazyVStack(alignment: .leading, spacing: 0) {
            mainHeader(restaurant: restaurant)
            
            description(restaurant: restaurant)
            
            Divider()
            
            menu(restaurant: restaurant)
            
            Divider()
            
            location(restaurant: restaurant)
            
            Divider()
            
            review(restaurant: restaurant)
        }
    }
}
