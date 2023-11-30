//
//  SearchViewModel.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 22/11/2023.
//

import Foundation
class SearchViewModel: ObservableObject {
    private var service: ApiServicesProtocol?
    @Published var gifs: [GifObject]?
    @Published var searchText: String = ""
    @Published var pageTitle: String = ""
    var offset: Int = 0
    var limit: Int = Int(AppConfiguration.itemsPerPape)!
    
    enum State: Equatable {
        case loading
        case error(message: String)
        case loaded(gifs: [GifObject]?)
    }
    @Published var state: State = .loaded(gifs: nil)
    
    init (service: ApiServicesProtocol) {
        self.service = service
    }
    
    init (service: ApiServicesProtocol, searchText: String, pageTitle: String) {
        self.service = service
        self.searchText = searchText
        self.pageTitle = pageTitle
    }

    init(with gifs: [GifObject]?) {
        self.gifs = gifs
        self.state = .loaded(gifs: gifs)
    }
    
    init(with gifs: [GifObject]?, searchText: String, pageTitle: String) {
        self.gifs = gifs
        self.state = .loaded(gifs: gifs)
        self.searchText = searchText
        self.pageTitle = pageTitle
    }
    
    func fetchListBy(searchText: String, limit: String?, offset: String?) {
        if let service = service {
            let lmt = limit ?? AppConfiguration.itemsPerPape
            let ofst = offset ?? "0"
            service.searchImagesBy(q: searchText, limit: lmt, offset: ofst){ [weak self] result in
                switch result {
                case .failure(let error):
                    self?.state = .error(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .success(let response):
                    if let self = self {
                        self.gifs = response.data
                        self.state = .loaded(gifs: gifs)
                    }
                }
            }
        }
    }
        

    func search() {
        if let service = service {
            service.searchImagesBy(q: searchText, limit: "\(limit)", offset: "\(offset)"){ [weak self] result in
                switch result {
                case .failure(let error):
                    self?.state = .error(message: error.localizedDescription)
                    print(error.localizedDescription)
                case .success(let response):
                    if let self = self {
                        self.gifs = response.data
                        self.state = .loaded(gifs: gifs)
                    }
                }
            }
        }
    }
    
    func loadMoreSearch() {
        let off = offset + limit
        offset = off
        search()
    }
    
    func searchA() async {
        if let service = service {
            let result = await service.searchImagesByA(q: searchText, limit: "\(limit)", offset: "\(offset)")
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .error(message: error.localizedDescription)
                    print(error.localizedDescription)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.gifs = response.data
                    self.state = .loaded(gifs: self.gifs)
                }
            }            
        }
    }
    
    func loadMoreSearchA() async {
        let off = self.offset + self.limit
        self.offset = off
        await self.searchA()
    }
    
}
