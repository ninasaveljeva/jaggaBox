//
//  ImageModel.swift
//  watchApp Watch App
//
//  Created by Nina Saveljeva on 13/11/2023.
//

import Foundation

struct GifObject: Codable, Equatable, Hashable {
    let id: String
    let type: String
    let url: String
    let title: String
    let alt_text: String?
    let images: ImageObject
}

struct ImageObject: Codable, Equatable, Hashable {
    let fixed_width_small: ImageSmall
    let fixed_width: ImageFixedWidth
}

struct ImageFixedWidth: Codable, Equatable, Hashable {
    let height: String
    let width: String
    let url: String
}

struct ImageSmall: Codable, Equatable, Hashable {
    let height: String?
    let width: String?
    let url: String?
}

struct ImageModelResponse: Codable {
    let data: [GifObject]
    let pagination: PaginationObject?
    let meta: MetaObject?
}

struct PaginationObject: Codable {
    
}

struct MetaObject: Codable {
    
}
