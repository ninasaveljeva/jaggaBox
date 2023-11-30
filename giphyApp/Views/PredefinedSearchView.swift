//
//  PredefinedSearchView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 24/11/2023.
//

import SwiftUI

struct PredefinedSearchView: View {
    @Environment(\.refresh) private var refreshAction
    @State private var isRefreshing = false
    @ObservedObject var searchViewModel: SearchViewModel
    
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
                    .navigationTitle(searchViewModel.pageTitle)
                    .padding([.leading, .trailing], 10)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .toolbar {
            if let refreshAction = refreshAction {
                
                Button {
                    print("refresh")
                    Task {
                        isRefreshing = true
                        await refreshAction()
                        isRefreshing = false
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .tint(.white)
                }
                .disabled(isRefreshing)
                .opacity(isRefreshing ? 0 : 1)
                .overlay {
                    if isRefreshing {
                        ProgressView()
                    }
                }
            }
        }
#if os(iOS)
        .background(Color("BgColor"))
        .foregroundColor(Color("FgColor"))
#endif
        .onAppear(){
            Task {
               await searchViewModel.searchA()
            }
        }
        
    }
    
}

struct PredefinedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PredefinedSearchView(searchViewModel:
                                    SearchViewModel(with: MockupData.gifsList,
                                                    searchText: "i love you",
                                                    pageTitle: "Search I Love"))
            .refreshable {
                
            }
        }
    }
}
