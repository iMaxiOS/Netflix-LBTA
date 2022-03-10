//
//  APIError.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import Foundation

enum APIError: String, Error {
    case failedTogetMovies
    
    var localizedDescription: String {
        switch self {
        case .failedTogetMovies: return "Failed request"
        }
    }
}
