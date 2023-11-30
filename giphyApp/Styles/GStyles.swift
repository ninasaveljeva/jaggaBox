//
//  GStyles.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 13/11/2023.
//
import Foundation
import SwiftUI

struct ImageCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
    
}


import UIKit

class SGConvenience {
#if os(watchOS)
    static let screenSize = WKInterfaceDevice.current().screenBounds.size
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
#elseif os(iOS) || os(tvOS)
    static let screenSize = UIScreen.main.nativeBounds.size
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
#elseif os(macOS)
    static let screenSize = NSScreen.main?.visibleFrame.size
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
#endif
    static let middleOfScreen = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
}
