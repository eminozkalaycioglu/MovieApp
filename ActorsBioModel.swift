//
//  ActorsBioModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - ActorsBioModel
public struct ActorsBioModel : Decodable {

    public var adult : Bool?
    public var alsoKnownAs : [String]?
    public var biography : String?
    public var birthday : String?
    public var deathday : String?
    public var gender : Int?
    public var homepage : String?
    public var id : Int?
    public var imdbId : String?
    public var knownForDepartment : String?
    public var name : String?
    public var placeOfBirth : String?
    public var popularity : Float?
    public var profilePath : String?
    
    
    enum CodingKeys : String, CodingKey {
        case profilePath = "profile_path"
        case adult = "adult"
        case alsoKnownAs = "also_known_as"
        case biography = "biography"
        case id = "id"
        case birthday = "birthday"
        case gender = "gender"
        case homepage = "homepage"
        case imdbId = "imdb_id"
        case knownForDepartment = "known_for_deparment"
        case name = "name"
        case placeOfBirth = "place_of_birth"
        case popularity = "popularity"
    }
    
        
}
