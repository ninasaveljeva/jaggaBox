//
//  GifsListView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 13/11/2023.
//

import SwiftUI

struct TrendingGifsView: View {
    @StateObject var gifsViewModel: GifsViewModel
        
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                switch (gifsViewModel.state) {
                case .error(let message):
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(.red)
                case .loading:
                    ProgressView()
                        .tint(.blue)
                default:
                    
                    if let gifs = gifsViewModel.gifs {
                        ForEach(gifs, id: \.self) { gif in
                            GifView(image: gif.images.fixed_width.url,
                                    title: gif.title,
                                    width: gif.images.fixed_width.width,
                                    height: gif.images.fixed_width.height)
                            .fixedSize(horizontal: false, vertical: true)
                            
                        }
                        .navigationTitle("Trending")
                        .padding([.leading, .trailing], 10)
                        
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
#if os(iOS)
        .background(Color("BgColor"))
#endif
        .onAppear {
            gifsViewModel.fetchList()
        }
    }
}

struct TrendingGifsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrendingGifsView(gifsViewModel: GifsViewModel(with: MockupData.gifsList))
        }
        .navigationViewStyle(.stack)
    }
}
