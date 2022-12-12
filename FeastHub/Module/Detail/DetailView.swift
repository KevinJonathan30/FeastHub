//
//  DetailView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import CachedAsyncImage

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
        }
        .navigationBarTitle("Detail", displayMode: .inline)
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
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
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
                        .font(.caption)
                        .padding(4)
                        .background(Color.random.opacity(0.3))
                        .cornerRadius(8)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top)
    }
    
    @ViewBuilder
    func description(restaurant: RestaurantModel) -> some View {
        Text(restaurant.description)
            .font(.system(size: 15))
    }
    
    @ViewBuilder
    func menu(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .leading) {
            ForEach(restaurant.menus.foods) { food in
                Text(food.name)
                    .font(.caption)
                    .padding(4)
                    .background(Color.random.opacity(0.3))
                    .cornerRadius(8)
            }
            
            ForEach(restaurant.menus.drinks) { drink in
                Text(drink.name)
                    .font(.caption)
                    .padding(4)
                    .background(Color.random.opacity(0.3))
                    .cornerRadius(8)
            }
        }
    }
    
    @ViewBuilder
    func review(restaurant: RestaurantModel) -> some View {
        VStack(alignment: .leading) {
            ForEach(restaurant.customerReviews) { review in
                Text(review.name)
                    .font(.headline)
                    .bold()
                
                Text(review.date)
                    .font(.subheadline)
                
                Text(review.review)
                    .font(.body)
                
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
    func content() -> some View {
        let restaurant = self.presenter.restaurant
        
        LazyVStack(alignment: .leading, spacing: 0) {
            mainHeader(restaurant: restaurant)
            
            Spacer()
            
            subheaderTitle("Description")
                .padding(.vertical)
            
            description(restaurant: restaurant)
                .padding(.bottom)
            
            Divider()
            
            subheaderTitle("Menu")
                .padding(.vertical)
            
            menu(restaurant: restaurant)
            
            Divider()
                .padding(.top)
            
            subheaderTitle("Customer Reviews")
                .padding(.vertical)
            
            review(restaurant: restaurant)
        }
    }
}
