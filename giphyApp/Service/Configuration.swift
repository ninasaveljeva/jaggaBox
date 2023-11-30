//
//  Config.swift
//  quiz-ios
//
//  Created by Nina Saveljeva on 20/5/2022.
//

import Foundation

struct AppConfiguration {
    enum Environment {
        case development
        case production
    }
    
    static let env: Environment = .development
    static var serverURL: String {
        switch env {
        case .development: return "https://api.giphy.com"
        case .production: return ""
        }
    }
                
    static let apiURL = "\(serverURL)/v1"
    static let apiKey = ""

    static let itemsPerPape = "10" //for categories search
    static let itemsPerPapeTrending = "25" //for trending
}







