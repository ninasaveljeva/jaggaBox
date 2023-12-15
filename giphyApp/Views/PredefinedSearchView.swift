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
    @State var searchCategory: String
    
    init(vm: SearchViewModel, txt: String) {
        searchViewModel = vm
        _searchCategory = State(initialValue: txt)
        searchViewModel.setSearchData(searchText: searchCategory)
    }
    var body: some View {
        
        ScrollView {
            VStack(spacing: 12) {
                switch (searchViewModel.state) {
                case .loading:
                    ProgressView()
                        .tint(.blue)
                case .error(let message):
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(.red)
                default:
                    let _ = print(searchViewModel.state)
                    
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
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .toolbar {
            //if let refreshAction = refreshAction {
                
                Button {
                    print("refresh")
                    Task {
                        isRefreshing = true
                        //await refreshAction()
                        await searchViewModel.loadMoreSearchA()
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
           // }
        }
#if os(iOS)
        .background(Color("BgColor"))
        .foregroundColor(Color("FgColor"))
#endif
        .onAppear(){
            print("on appear")
            Task {
               await searchViewModel.searchA()
            }
        }
        
    }
    
}

struct PredefinedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PredefinedSearchView(vm:
                                    SearchViewModel(with: MockupData.gifsList,
                                                    searchText: "i love you",
                                                    pageTitle: "Search I Love"), 
                                 txt: "i love you")
            .refreshable {
                
            }
        }
    }
}
