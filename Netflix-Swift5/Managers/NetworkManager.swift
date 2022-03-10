//
//  NetworkManager.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import Foundation

let sharedNetworkManager = { NetworkManager.shared }

final class NetworkManager {
    static let shared = NetworkManager()
    
    func getTrandingMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/3/movie/popular?api_key=" + Constants.API_KEY) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(MovieListResponse.self, from: data)
                
                completion(.success(movies.movie))
            } catch {
                completion(.failure(APIError.failedTogetMovies))
            }
        }
        
        task.resume()
    }
    
    func getTrandingTvs(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/3/tv/popular?api_key=" + Constants.API_KEY) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let tvs = try decoder.decode(MovieListResponse.self, from: data)

                completion(.success(tvs.movie))
            } catch {
                completion(.failure(APIError.failedTogetMovies))
            }
        }
        
        task.resume()
    }
    
    func getMoviesUpcoming(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/3/movie/upcoming?api_key=" + Constants.API_KEY) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let moviesUpcoming = try decoder.decode(MovieListResponse.self, from: data)

                completion(.success(moviesUpcoming.movie))
            } catch {
                completion(.failure(APIError.failedTogetMovies))
            }
        }
        
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/3/movie/popular?api_key=" + Constants.API_KEY + "&language=en-US&page=1") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let moviesUpcoming = try decoder.decode(MovieListResponse.self, from: data)

                completion(.success(moviesUpcoming.movie))
            } catch {
                completion(.failure(APIError.failedTogetMovies))
            }
        }
        
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + "/3/movie/top_rated?api_key=" + Constants.API_KEY + "&language=en-US&page=1") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let moviesUpcoming = try decoder.decode(MovieListResponse.self, from: data)

                completion(.success(moviesUpcoming.movie))
            } catch {
                completion(.failure(APIError.failedTogetMovies))
            }
        }
        
        task.resume()
    }
}
