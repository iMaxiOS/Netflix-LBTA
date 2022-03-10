//
//  MovieListResponse.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import Foundation

struct MovieListResponse: Decodable {
    let movie: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movie = "results"
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String?
    let overview: String?
    let posterImage: String?
    let releaseDate: String?
    let rate: Double?
    
    var urlImage: URL? {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w300\((posterImage ?? ""))") else {
            return URL(string: "")
        }
        
        return url
    }
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case title = "original_title"
        case posterImage = "poster_path"
        case releaseDate = "release_date"
        case rate = "vote_average"
    }
}
