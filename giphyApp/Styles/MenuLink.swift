//
//  MenuLink.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 15/12/2023.
//

import SwiftUI

struct MenuLink: View {
    let buttonTitle: String
    let buttonImageName: String?
    
    var body: some View {
        VStack {
            if let buttonImageName = buttonImageName {
                Image(systemName: buttonImageName)
                    .resizable()
                    .scaledToFit()
#if os(iOS)
                    .frame(width: 80, height: 80)
#elseif os(watchOS)
                    .frame(width: 45, height: 45)
#endif
                    
            }
            Text(buttonTitle)
#if os(iOS)
                .font(.title3)
#elseif os(watchOS)
                .font(.caption2)
#endif

        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .foregroundColor(Color("FgColor"))
        .background(Color("BgItemColor"))
        .cornerRadius(15)
        
    }
}

#Preview {
    MenuLink(buttonTitle: "Test", buttonImageName: "heart")
}


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
#if os(iOS)
                    .frame(width: 80, height: 80)
#elseif os(watchOS)
                    .frame(width: 45, height: 45)
#endif
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

