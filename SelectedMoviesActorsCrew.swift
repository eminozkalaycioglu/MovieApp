//
//  SelectedMoviesActorsCrew.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMoviesActorsCrew
public struct SelectedMoviesActorsCrew : Decodable{

        public var creditId : String?
        public var department : String?
        public var gender : Int?
        public var id : Int?
        public var job : String?
        public var name : String?
        public var profilePath : String?
    
    enum CodingKeys : String, CodingKey {
        case creditId = "creditId"
        case department = "department"
        case gender = "gender"
        case id = "id"
        case job = "job"
        case name = "name"
        case profilePath = "profile_path"
        
    }
        
}
