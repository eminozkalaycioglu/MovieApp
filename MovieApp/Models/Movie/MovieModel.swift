//
//  MovieModel.swift
//  MovieApp
//
//  Created by kuka apps on 2.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import Foundation

struct MovieResponseModel: Decodable {
    
    let page: Int?
    let total_results: Int?
    let total_page: Int?
    let results: [ResultModel]?
    
    enum CodingKeys : String, CodingKey {
        case page = "page"
        case total_results = "total_results"
        case total_page = "total_pages"
        case results = "results"
    }
}


struct ResultModel: Decodable {
    public var adult : Bool!
    public var backdropPath : String!
    public var genreIds : [Int]!
    public var id : Int!
    public var originalLanguage : String!
    public var originalTitle : String!
    public var overview : String!
    public var popularity : Float!
    public var posterPath : String!
    public var releaseDate : String!
    public var title : String!
    public var video : Bool!
    public var voteAverage : Float!
    public var voteCount : Int!
    
    enum CodingKeys : String, CodingKey {
        case adult = "adult"
        case overview = "overview"
        case popularity = "popularity"
        case video = "video"
        case backdropPath = "backdrop_path"
        case id = "id"
        case title = "title"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
    
}

