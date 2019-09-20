//
//  SelectedMovieGenre.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMovieGenre
public struct SelectedMovieGenre : Decodable{

        public var id : Int?
        public var name : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
    }
        
}
