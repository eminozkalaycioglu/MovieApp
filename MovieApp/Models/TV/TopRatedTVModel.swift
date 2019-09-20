//
//  TopRatedTVModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 13, 2019

import Foundation

//MARK: - TopRatedTVModel
public struct TopRatedTVModel : Decodable {

        public var page : Int?
        public var results : [TopRatedTVResult]?
        public var total_pages : Int?
        public var total_results : Int?
        
}

public struct TopRatedTVResult : Decodable {

        public var backdrop_path : String?
        public var first_air_date : String?
        public var genre_ids : [Int]?
        public var id : Int?
        public var name : String?
        public var origin_country : [String]?
        public var original_language : String?
        public var original_name : String?
        public var overview : String?
        public var popularity : Float?
        public var poster_path : String?
        public var vote_average : Float?
        public var vote_count : Int?
        
}
