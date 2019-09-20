//
//  SelectedMovieProductionCompany.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMovieProductionCompany
public struct SelectedMovieProductionCompany : Decodable{

        public var id : Int!
        public var logoPath : String!
        public var name : String!
        public var originCountry : String!
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case logoPath = "logoPath"
        case originCountry = "originCountry"
        case name = "name"
    }
        
}
