//
//  RestaurantCard.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI
import CachedAsyncImage

struct RestaurantCard: View {
    var restaurant: RestaurantModel
    
    var body: some View {
        VStack {
            image()
            content()
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(Color.random.opacity(0.25))
        .cornerRadius(8)
    }
}

// MARK: ViewBuilder

extension RestaurantCard {
    @ViewBuilder
    func image() -> some View {
        CachedAsyncImage(url: URL(string: "https://restaurant-api.dicoding.dev/images/medium/\(restaurant.pictureId)")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }.scaledToFit()
    }
    
    @ViewBuilder
    func content() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.name)
                .font(.title2)
                .bold()
            
            Text("⭐️ \(String(format: "%.1f", restaurant.rating)) - \(restaurant.city)")
                .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
    
}

struct RestaurantCard_Previews: PreviewProvider {
    
    static var previews: some View {
        let restaurant = RestaurantModel(
            id: UUID().uuidString,
            name: "Resto Mantap Jiwa",
            description: "Banyak ayam geprek disini",
            pictureId: "14",
            city: "Surabaya",
            rating: 5.0,
            address: "",
            categories: [],
            menus: MenuModel(),
            customerReviews: []
        )
        return RestaurantCard(restaurant: restaurant)
    }
    
}
