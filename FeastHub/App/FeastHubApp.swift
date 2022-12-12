//
//  FeastHubApp.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import SwiftUI

@main
struct FeastHubApp: App {
    let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.init().provideFavorite())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
