//
//  giphyAppApp.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 10/11/2023.
//

import SwiftUI

@main
struct giphyAppApp: App {
    init() {
//        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]

        UITabBar.appearance().barTintColor = .black
          
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
        
    }

   
    
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
    }
}
