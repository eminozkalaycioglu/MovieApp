//
//  SelectedMoviesActorsModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMoviesActorsModel
public struct SelectedMoviesActorsModel : Decodable{

        public var cast : [SelectedMoviesActorsCast]?
        public var crew : [SelectedMoviesActorsCrew]?
        public var id : Int?
    
    enum CodingKeys : String, CodingKey {
        case cast = "cast"
        case crew = "crew"
        case id = "id"
    }
        
}
