//
//  SelectedMovieSpokenLanguage.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMovieSpokenLanguage
public struct SelectedMovieSpokenLanguage : Decodable{

        public var iso6391 : String!
        public var name : String!
    
    enum CodingKeys : String, CodingKey {
        case iso6391 = "iso6391"
        case name = "name"
    }
        
}
