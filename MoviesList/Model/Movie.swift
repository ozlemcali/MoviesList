//
//  Movie.swift
//  MoviesList
//
//  Created by ozlem on 4.11.2022.
//

import Foundation

struct MovieResponse: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
}

struct Movie: Decodable {
    let imdbID: String
    let title: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case imdbID = "imdbID"
        case title = "Title"
        case poster = "Poster"
    }
    
}
