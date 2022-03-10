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
    
    func getTranding(completion: @escaping (Result<MovieListResponse, APIError>) -> Void) {
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
                
                completion(.success(movies))
            } catch {
                print("download isn`t complition \(error.localizedDescription)")
                completion(.failure(APIError.failedTogetMovies))
            }
        }
        
        task.resume()
    }
    
}
