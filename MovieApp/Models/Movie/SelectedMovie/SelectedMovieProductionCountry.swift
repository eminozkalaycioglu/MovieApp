//
//  SelectedMovieProductionCountry.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMovieProductionCountry
public struct SelectedMovieProductionCountry : Decodable{

        public var iso31661 : String!
        public var name : String!
    
    enum CodingKeys : String, CodingKey {
        case iso31661 = "iso31661"
        case name = "name"
    }
        
}
