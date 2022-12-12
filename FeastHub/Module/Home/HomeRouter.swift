//
//  HomeRouter.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 11/12/22.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for restaurant: RestaurantModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(restaurant: restaurant)
        let presenter = DetailPresenter(detailUseCase: detailUseCase, restaurant: restaurant)
        return DetailView(presenter: presenter)
    }
}
