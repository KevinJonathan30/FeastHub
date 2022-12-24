//
//  ContentView.swift
//  FeastHub
//
//  Created by Kevin Jonathan on 10/12/22.
//

import SwiftUI
import CorePackage

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "home_title".localized())
            }
            
            NavigationStack {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "star.fill", title: "favorite_title".localized())
            }
        }
    }
}
