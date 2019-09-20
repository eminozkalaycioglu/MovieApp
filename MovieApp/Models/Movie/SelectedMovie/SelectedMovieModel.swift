//
//  SelectedMovieModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 5, 2019

import Foundation

//MARK: - SelectedMovieModel
public struct SelectedMovieModel : Decodable{

    var adult : Bool!
    var backdropPath : String!
    var belongsToCollection : SelectedMovieBelongsToCollection!
    var budget : Int!
    var genres : [SelectedMovieGenre]!
    var homepage : String!
    var id : Int!
    var imdbId : String!
    var originalLanguage : String!
    var originalTitle : String!
    var overview : String!
    var popularity : Float!
    var posterPath : String!
    var productionCompanies : [SelectedMovieProductionCompany]!
    var productionCountries : [SelectedMovieProductionCountry]!
    var releaseDate : String!
    var revenue : Int!
    var runtime : Int!
    var spokenLanguages : [SelectedMovieSpokenLanguage]!
    var status : String!
    var tagline : String!
    var title : String!
    var video : Bool!
    var voteAverage : Float!
    var voteCount : Int!
    
    
    enum CodingKeys : String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget = "budget"
        case voteCount = "vote_count"
        case title = "title"
        case voteAverage = "vote_average"
        case video = "video"
        case tagline = "tagline"
        case status = "status"
        case spokenLanguages = "spoken_languages"
        case runtime = "runtime"
        case revenue = "revenue"
        case releaseDate = "release_date"
        case productionCountries = "production_countries"
        case productionCompanies = "production_companies"
        case posterPath = "poster_path"
        case popularity = "popularity"
        case overview = "overview"
        
        case originalLanguage = "original_language"
        case id = "id"
        case imdbId = "imdb_id"
        case originalTitle = "original_title"
        
        case homepage = "homepage"
        case genres = "genres"
      
    }
        
}
