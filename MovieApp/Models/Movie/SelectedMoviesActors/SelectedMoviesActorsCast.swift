//
//  SelectedMoviesActorsCast.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMoviesActorsCast
public struct SelectedMoviesActorsCast : Decodable{

        public var castId : Int?
        public var character : String?
        public var creditId : String?
        public var gender : Int?
        public var id : Int?
        public var name : String?
        public var order : Int?
        public var profilePath : String?
    
    enum CodingKeys : String, CodingKey {
        case profilePath = "profile_path"
        case castId = "cast_id"
        case creditId = "credit_id"
        case gender = "gender"
        case id = "id"
        case name = "name"
        case order = "order"
        case character = "character"
        
    }
        
}
