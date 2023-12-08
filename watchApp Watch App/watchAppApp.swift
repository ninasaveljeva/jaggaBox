//
//  watchAppApp.swift
//  watchApp Watch App
//
//  Created by Nina Saveljeva on 13/11/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics



@main
struct watchApp_Watch_AppApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
    }
}
