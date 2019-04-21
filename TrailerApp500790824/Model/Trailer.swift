//
//  Trailer.swift
//  TrailerApp500790824
//
//  Created by Dennis Pagarusha on 12/04/2019.
//  Copyright © 2019 Dennis Pagarusha. All rights reserved.
//

import Foundation

class Trailer: Decodable {
    let id: Int
    let title: String
    let trailerUrl: String
    let posterImageUrl: String
    let stillImageUrl: String
    let genres: [String]
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case trailerUrl = "url"
        case posterImageUrl = "posterImage"
        case stillImageUrl = "stillImage"
        case genres = "genre"
        case description = "description"
    }
}
