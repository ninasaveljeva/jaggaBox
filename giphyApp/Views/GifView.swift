//
//  GifView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 13/11/2023.
//

import SwiftUI

struct GifView: View {
    var image: String
    var title: String
    var width: String
    var height: String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            AsyncImage(url: URL(string: "\(image)")) { image in
                image
                    .resizable()
                    //.frame(width: w, height: h)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
                    .tint(.red)
            }

            HStack(alignment: .bottom){
                Text(title)
                    .font(.headline)
                    //.fixedSize(horizontal: false, vertical: true)
                Spacer()
                ShareLink(item: URL(string: "\(image)")!) {
                    Image(systemName: "square.and.arrow.up")
                }
                .frame(maxWidth: 35)
            }
        }
        .padding(.all, 10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("BgItemColor"))
        .foregroundColor(.white)
        .modifier(ImageCardModifier())
    }
}

struct GifView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MockupData.gifsList[0]
        GifView(image: vm.images.fixed_width_small.url, title: vm.title, width: "100", height: "100")
    }
}
