//
//  SearchView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 22/11/2023.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var searchData = ""
    var body: some View {
        let _ = Self._printChanges()
        
        ScrollView {
            
            VStack(spacing: 12) {
                VStack {
                    Text("Click button to add a search word")
                        .foregroundColor(.white)
                        .font(.caption)
                    TextFieldLink {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    } onSubmit: { value in
                        self.searchData = value
                        print("text11: \(searchData)")
                        runSearch()
                    }
                    Text("Search result for: \(searchData)")
                        .foregroundColor(.white)
                        .font(.caption)
                }
                
                switch (searchViewModel.state) {
                case .error(let message):
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(.red)
                default:
                    if let gifs = searchViewModel.gifs {
                        ForEach(gifs, id: \.self) { gif in
                            GifView(image: gif.images.fixed_width.url,
                                    title: gif.title,
                                    width: gif.images.fixed_width.width,
                                    height: gif.images.fixed_width.height)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .navigationTitle("Search")
                        .padding([.leading, .trailing], 10)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .foregroundColor(Color("BgColor"))
        
    }
    
    func runSearch() {
        Task {
            print("search for \(searchData)")
            if searchData != "" {
                searchViewModel.fetchListBy(searchText: searchData, limit: AppConfiguration.itemsPerPape, offset: "0")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView(searchViewModel: SearchViewModel(with: MockupData.gifsList))
            
        }
    }
}
