//
//  MenuView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 23/11/2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject var searchVM = SearchViewModel(service: ApiService.shared)
    
    @State private var searchCategogies: [SearchCategory] = [
        SearchCategory(title: "I Love You", img: "heart"),
        SearchCategory(title: "Congrats", img: "gift"),
        SearchCategory(title: "Morning", img: "sun.max"),
        SearchCategory(title: "Good Luck", img: "hand.thumbsup"),
        SearchCategory(title: "Search", img: "magnifyingglass"),
        SearchCategory(title: "Trending", img: "list.bullet.clipboard")
        
    ]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            
            
            // ScrollView {
            GeometryReader { geometry in
                VStack (alignment: .center) {
                    Text("Choose category to get images")
                        .font(.title2)
                    Spacer()
                    
                    LazyVGrid(columns: columns) {
                        ForEach(searchCategogies, id: \.self) { cat in
                            NavigationLink(value: cat) {
                                MenuLink(buttonTitle: cat.title,
                                         buttonImageName: cat.img)
                                .frame(height: 200)
                            }
                        }
                    }
                    .frame(height: 200)
                    Spacer()
                    Text("Powered by Giphy")
                        .font(.footnote)
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .fixedSize(horizontal: false, vertical: true)
                .navigationDestination(for: SearchCategory.self) { cat in
                    if (cat.title == "Trending") {
                        TrendingGifsView(gifsViewModel: GifsViewModel(service: ApiService.shared))
                    } else if( cat.title == "Search") {
                        SearchView(searchViewModel: SearchViewModel(service: ApiService.shared))
                    } else {
                        PredefinedSearchView(vm: searchVM, txt: cat.title)
                            .refreshable {
                                await searchVM.loadMoreSearchA()
                            }
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
