//
//  MainView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 22/11/2023.
//

import SwiftUI

struct MainView: View {   
    var body: some View {
        TabView {
            TrendingGifsView(gifsViewModel: GifsViewModel(service: ApiService.shared))
                .tabItem {
                    Label("Trending", systemImage: "list.bullet.clipboard")
                }
            SearchView(searchViewModel: SearchViewModel(service: ApiService.shared))
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                
        }
        .tint(.white)       


    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
