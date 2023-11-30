//
//  ImageListViewModel.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 13/11/2023.
//

import Foundation
class GifsViewModel: ObservableObject {
    private var service: ApiServicesProtocol?
    @Published var gifs: [GifObject]?
    
    enum State: Equatable {
        case loading
        case error(message: String)
        case loaded(gifs: [GifObject]?)
    }
    @Published var state: State = .loaded(gifs: nil)
    
    init (service: ApiServicesProtocol) {
        self.service = service
    }
    
    init(with gifs: [GifObject]?) {
        self.gifs = gifs
        self.state = .loaded(gifs: gifs)
    }
    
    func fetchList() {
        if let service = service {

            service.fetchImageList { [weak self] result in
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
        

}
