//
//  MenuView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 23/11/2023.
//

import SwiftUI
import FirebaseCrashlytics

struct MenuView: View {
    @StateObject var searchVM = SearchViewModel(service: ApiService.shared)
    
    @State private var searchCategogies: [SearchCategory] = [
        SearchCategory(title: "i love you", img: "heart"),
        SearchCategory(title: "Congrats", img: "gift"),
        SearchCategory(title: "Search", img: "magnifyingglass"),
        SearchCategory(title: "Trending", img: "list.bullet.clipboard")
    ]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack (alignment: .center, spacing: 10) {
                    
                    LazyVGrid(columns: columns) {
                        ForEach(searchCategogies, id: \.self) { cat in
                            NavigationLink(value: cat) {
                                MenuLink(buttonTitle: cat.title,
                                         buttonImageName: cat.img)
                                .frame(height: abs(geometry.size.height - 10)/2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding([.leading, .trailing], 10)
                    
                    Text("Powered by Giphy")
                        .font(.footnote)
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .fixedSize(horizontal: false, vertical: true)
                .navigationDestination(for: SearchCategory.self) { cat in
                    if (cat.title == "Trending") {
                        TrendingGifsView(gifsViewModel: GifsViewModel(service: ApiService.shared))
                    } else if( cat.title == "Search") {
                        SearchView(searchViewModel: SearchViewModel(service: ApiService.shared))
                    } else {
                        PredefinedSearchView(vm: searchVM, txt: cat.title)
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
