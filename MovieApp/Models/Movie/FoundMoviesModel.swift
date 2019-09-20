//
//  FoundMoviesModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 18, 2019

import Foundation

//MARK: - FoundMoviesModel
public struct FoundMoviesModel : Decodable {

        public var page : Int?
        public var results : [FoundMoviesResult]?
        public var total_pages : Int?
        public var total_results : Int?
}


public struct FoundMoviesResult : Decodable {

        public var adult : Bool?
        public var backdrop_path : String?
        public var genre_ids : [Int]?
        public var id : Int?
        public var original_language : String?
        public var original_title : String?
        public var overview : String?
        public var popularity : Float?
        public var poster_path : String?
        public var release_date : String?
        public var title : String?
        public var video : Bool?
        public var vote_average : Float?
        public var vote_count : Int?
}

