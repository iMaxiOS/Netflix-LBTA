//
//  YoutubeModelResponse.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 11.03.2022.
//

import Foundation

struct YoutubeModelResponse: Decodable {
    let items: [ItemElement]
    
    struct ItemElement: Decodable {
        let id: VideoIdElement
    }
    
    struct VideoIdElement: Decodable {
        let kind: String
        let videoId: String
    }
}
