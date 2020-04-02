//
//  NetworkService.swift
//  MovieDB_SwiftUI
//
//  Created by Matheus Lima Ferreira on 4/1/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

import UIKit

enum ResultError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to completed your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from server. Please try again"
    case invalidData        = "The data received from the server is invalid. Please try again"
}

enum MovieCategory {
    case POPULAR
    case NOW_PLAYING
}

struct MoviesResults: Codable {
    var results:[Movie]
}
class NetworkService {
    
    let API_KEY = "6af6fb6deb5f2e4c6d36e514240eeebb"
    
    static var sharedInstance = NetworkService()
    
    let cache = NSCache<NSString, UIImage>()
    
    let popularBaseUrl: String = "https://api.themoviedb.org/3/movie/popular?api_key="
    let nowPlayingBaseUrl: String = "https://api.themoviedb.org/3/movie/now_playing?api_key="
    
    
    
    func fetchMovies(with category: MovieCategory, completion: @escaping (Result<[Movie], ResultError>) -> Void) {
        var urlString: String = ""
        
        if(category == .POPULAR) {
            urlString = "\(popularBaseUrl)\(API_KEY)&language=en-US&page=1"
        } else if(category == .NOW_PLAYING) {
            urlString = "\(nowPlayingBaseUrl)\(API_KEY)&language=en-US&page=1"
        }
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                var movies : [Movie] = []
                if let moviesResults = try? decoder.decode(MoviesResults.self, from: data) {
                    movies = moviesResults.results
                }
                
                
                completion(.success(movies))
            }catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    
    func fetchImageFromUrl(poster_path: String, completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)") else {return}
        
        let task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                print("Error to fetch image \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let data = data else {
                print("error to try fetch data")
                return
            }
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: NSString(string: poster_path))
            completion(image)
            
        }
        task.resume()
    }
    
    
    
    
    func getImageFromUrl(poster_path: String, completion: @escaping (Result <UIImage, ResultError>) -> Void) {
        

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: NSString(string: poster_path))
            completion(.success(image))
        }
        
        task.resume()
    }
    
    func getLocalImage(from posterPath: String) -> UIImage{
        let cacheKey = NSString(string: posterPath)
        
        guard let image = cache.object(forKey: cacheKey) else {
            var image: UIImage = UIImage()
            
            getImageFromUrl(poster_path: posterPath) { result in
                switch result {
                case .success(let resultImage):
                    image =  resultImage
                case .failure(_): break
                    
                }
            }
            return image
        }
        return image
    }
}
