//
//  MenuView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 23/11/2023.
//

import SwiftUI

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
                        .frame(width: 80, height: 80)
                }
                Text(buttonTitle)
                    .font(.title3)
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
    @State private var showMorning = false
    @State private var showGoodLuck = false
    
    var body: some View {
        NavigationStack {
          // ScrollView {
                GeometryReader { geometry in
                    VStack (alignment: .center) {
                        Text("Choose category to get images")
                            .font(.title2)
                        Spacer()
                        HStack{
                            MenuButton(buttonTitle: "Congrats",
                                       action: {showCongats = true},
                                       buttonImageName: "gift")
                            MenuButton(buttonTitle: "Love you",
                                       action: {showLove = true},
                                       buttonImageName: "heart")
                        }
                        .frame(height: 200)
                        HStack{
                            MenuButton(buttonTitle: "Morning",
                                       action: {showMorning = true},
                                       buttonImageName: "sun.max")
                            MenuButton(buttonTitle: "Good Luck",
                                       action: {showGoodLuck = true},
                                       buttonImageName: "hand.thumbsup")
                        }
#if os(iOS)
                        .frame(height: 200)
#elseif os(watchOS)
                        .frame(height: geometry.size.height/2)
#endif
                        HStack {
                            MenuButton(buttonTitle: "Search",
                                       action: {showSearch = true},
                                       buttonImageName: "magnifyingglass")
                            MenuButton(buttonTitle: "Trending",
                                       action: {showTrending = true},
                                       buttonImageName: "list.bullet.clipboard")
                            
                        }
#if os(iOS)
                        .frame(height: 200)
#elseif os(watchOS)
                        .frame(height: geometry.size.height/2)
#endif
                        Spacer()
                        Text("Powered by Giphy")
                            .font(.footnote)
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height)
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
                            await vm.loadMoreSearchA()
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
                    .navigationDestination(isPresented: $showMorning) {
                        let vm = SearchViewModel(service: ApiService.shared,
                                                 searchText: "Good Morning",
                                                 pageTitle: "Good Morning")
                        PredefinedSearchView(searchViewModel: vm)
                        .refreshable {
                            vm.loadMoreSearch()
                        }
                    }
                    .navigationDestination(isPresented: $showGoodLuck) {
                        let vm = SearchViewModel(service: ApiService.shared,
                                                 searchText: "Good Luck",
                                                 pageTitle: "Good Luck")
                        PredefinedSearchView(searchViewModel: vm)
                        .refreshable {
                            vm.loadMoreSearch()
                        }
                    }
                }
                .background(Color("BgColor"))
           // }
        }
        .foregroundColor(Color("FgColor"))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuView()
        }
        
    }
}
