//
//  MenuView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 23/11/2023.
//

import SwiftUI
import FirebaseCrashlytics

struct MenuButton: View {
    let buttonTitle: String
    let action: () -> Void
    let buttonImageName: String?
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                if let buttonImageName = buttonImageName {
                    Image(systemName: buttonImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                Text(buttonTitle)
                    .font(.caption2)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .foregroundColor(Color("FgColor"))
        .background(Color("BgItemColor"))
        .cornerRadius(15)
        
    }
}


struct MenuView: View {
    @State private var showTrending = false
    @State private var showSearch = false
    @State private var showLove = false
    @State private var showCongats = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack (alignment: .center, spacing: 10) {                    
                    VStack (alignment: .center, spacing: 6) {
                        HStack{
                            MenuButton(buttonTitle: "Congrats",
                                       action: {showCongats = true},
                                       buttonImageName: "gift")
                            MenuButton(buttonTitle: "Love you",
                                       action: {showLove = true},
                                       buttonImageName: "heart")
                        }
                        .frame(height: geometry.size.height/2)
                        
                        HStack {
                            MenuButton(buttonTitle: "Search",
                                       action: {showSearch = true},
                                       buttonImageName: "magnifyingglass")
                            MenuButton(buttonTitle: "Trending",
                                       action: {showTrending = true},
                                       buttonImageName: "list.bullet.clipboard")
                            
                        }
                        .frame(height: geometry.size.height/2)
                    }
                    .padding([.leading, .trailing], 10)
                    Text("Powered by Giphy")
                        .font(.footnote)
                }
                .fixedSize(horizontal: false, vertical: true)
                .navigationDestination(isPresented: $showTrending) {
                    TrendingGifsView(gifsViewModel: GifsViewModel(service: ApiService.shared))
                }
                .navigationDestination(isPresented: $showSearch) {
                    SearchView(searchViewModel: SearchViewModel(service: ApiService.shared))
                }
                .navigationDestination(isPresented: $showLove) {
                    let vm = SearchViewModel(service: ApiService.shared,
                                             searchText: "i love you",
                                             pageTitle: "I Love You")
                    PredefinedSearchView(searchViewModel: vm)
                    .refreshable {
                        vm.loadMoreSearch()
                    }
                }
                .navigationDestination(isPresented: $showCongats) {
                    let vm = SearchViewModel(service: ApiService.shared,
                                             searchText: "Congrats",
                                             pageTitle: "Congrats")
                    PredefinedSearchView(searchViewModel: vm)
                        .refreshable {
                            vm.loadMoreSearch()
                        }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuView()
        }
        
    }
}
