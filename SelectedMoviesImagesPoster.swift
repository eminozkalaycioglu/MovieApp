//
//  SelectedMoviesImagesPoster.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 9, 2019

import Foundation

//MARK: - SelectedMoviesImagesPoster
public struct SelectedMoviesImagesPoster : Decodable {

        public var aspectRatio : Float?
        public var filePath : String?
        public var height : Int?
        public var iso6391 : String?
        public var voteAverage : Float?
        public var voteCount : Int?
        public var width : Int?
    
    
    enum CodingKeys : String, CodingKey {
        case filePath = "file_path"
        case aspectRatio = "aspect_ratio"
        case height = "height"
        case iso6391 = "iso6391"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width = "width"
        
    }
        
}
