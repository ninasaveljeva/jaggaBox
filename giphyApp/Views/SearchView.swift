//
//  SearchView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 22/11/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel: SearchViewModel
    @State private var searchData = ""
    var body: some View {
        let _ = Self._printChanges()
        
        ScrollView {
            
            VStack(spacing: 12) {                
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
#if os(iOS)
        .background(Color("BgColor"))
        .foregroundColor(Color("FgColor"))
#endif
        .searchable(text: $searchData, prompt: "Look for")
        .onSubmit(of: .search) {
            print("text: \(searchData)")
            runSearch()
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
