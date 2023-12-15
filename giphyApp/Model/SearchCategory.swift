//
//  SearchCategory.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 15/12/2023.
//

import Foundation

struct SearchCategory: Hashable, Identifiable {
    var title: String
    var img: String
    var id = UUID()
}
