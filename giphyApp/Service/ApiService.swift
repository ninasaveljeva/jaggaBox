//
//  WebService.swift
//  quizMVP
//
//  Created by Nina Saveljeva on 2/9/2022.
//

import Foundation

enum GifNetworkError: Error {
    case badURL
    case noData
    case decodingError
    case networkError
}

protocol ApiServicesProtocol: AnyObject {
    func fetchImageList(completion: @escaping (Result<ImageModelResponse, Error>) -> Void)
    func searchImagesBy(q: String, limit: String, offset: String, completion: @escaping (Result<ImageModelResponse, Error>) -> Void)
    func searchImagesByA(q: String, limit: String, offset: String) async -> Result<ImageModelResponse, Error> 
}

class ApiService: ApiServicesProtocol {
    static let shared = ApiService()
    
    
    func fetchImageList(completion: @escaping (Result<ImageModelResponse, Error>) -> Void)  {
        let endPointUrl = "\(AppConfiguration.apiURL)/gifs/trending"
        var urlComponents = URLComponents(string: endPointUrl)!
        
        let queryItems = [URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
                          URLQueryItem(name: "limit", value: AppConfiguration.itemsPerPapeTrending),
                          URLQueryItem(name: "offset", value: "0"),
                          URLQueryItem(name: "rating", value: "g")
        ]
        urlComponents.queryItems = queryItems
               
        guard let url = urlComponents.url else { completion(.failure(GifNetworkError.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("URL Session error: ", error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(GifNetworkError.noData))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(ImageModelResponse.self, from: data)
                    completion(.success(response))
                } catch let error {
                    print(error)
                    completion(.failure(GifNetworkError.decodingError))
                }
            }
        }
        task.resume()
        
    }
    
    func searchImagesBy(q: String, limit: String = "10", offset: String = "0", completion: @escaping (Result<ImageModelResponse, Error>) -> Void)  {
        let endPointUrl = "\(AppConfiguration.apiURL)/gifs/search"
        var urlComponents = URLComponents(string: endPointUrl)!
        
        let queryItems = [URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
                          URLQueryItem(name: "q", value: q),
                          URLQueryItem(name: "limit", value: limit),
                          URLQueryItem(name: "offset", value: offset),
                          URLQueryItem(name: "rating", value: "g")
        ]
        urlComponents.queryItems = queryItems
               
        guard let url = urlComponents.url else { completion(.failure(GifNetworkError.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("URL Session error: ", error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(GifNetworkError.noData))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(ImageModelResponse.self, from: data)
                    completion(.success(response))
                } catch let error {
                    print(error)
                    completion(.failure(GifNetworkError.decodingError))
                }
            }
        }
        task.resume()
        
    }
    
    func searchImagesByA(q: String, limit: String = "10", offset: String = "0") async -> Result<ImageModelResponse, Error>  {
        let endPointUrl = "\(AppConfiguration.apiURL)/gifs/search"
        var urlComponents = URLComponents(string: endPointUrl)!
        
        let queryItems = [URLQueryItem(name: "api_key", value: AppConfiguration.apiKey),
                          URLQueryItem(name: "q", value: q),
                          URLQueryItem(name: "limit", value: limit),
                          URLQueryItem(name: "offset", value: offset),
                          URLQueryItem(name: "rating", value: "g")
        ]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return .failure(GifNetworkError.badURL)
        }
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            print(response)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return .failure(GifNetworkError.networkError)
            }
            
            let r = try JSONDecoder().decode(ImageModelResponse.self, from: data)
            return .success(r)
        } catch (let error) {
            print(error)
            return .failure(error)
        }
        
    }
}
