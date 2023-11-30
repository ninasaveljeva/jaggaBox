//
//  SearchView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 22/11/2023.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchViewModel: SearchViewModel
    @State private var searchText = ""
    var body: some View {
        
        
        ScrollView {
            
            VStack(spacing: 12) {
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
            .frame(maxWidth: .infinity, alignment: .center)
        }
#if os(iOS)
        .background(Color("BgColor"))
        .foregroundColor(Color("FgColor"))
#endif
        .searchable(text: $searchText, prompt: "Look for")
        .foregroundColor(Color("BgColor"))
        .onSubmit(of: .search, runSearch)
    }
    
    func runSearch() {
        Task {
            print("search for \(searchText)")
            if searchText != "" {
                searchViewModel.fetchListBy(searchText: searchText, limit: AppConfiguration.itemsPerPape, offset: "0")
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
