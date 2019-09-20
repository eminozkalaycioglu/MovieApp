//
//  SelectedTVDetailModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 13, 2019

import Foundation

//MARK: - SelectedTVDetailModel
public struct SelectedTVDetailModel : Decodable {

        public var backdrop_path : String?
//        public var created_by : [String]?
//        public var episode_run_time : [Int]?
//        public var first_air_date : String?
        public var genres : [SelectedTVDetailGenre]?
        public var homepage : String?
        public var id : Int?
//        public var in_production : Bool?
//        public var languages : [String]?
//        public var last_air_date : String?
//        public var last_episode_to_air : SelectedTVDetailLastEpisodeToAir?
        public var name : String?
        public var networks : [SelectedTVDetailNetwork]?
//        public var next_episode_to_air : String?
        public var number_of_episodes : Int?
        public var number_of_seasons : Int?
//        public var origin_country : [String]?
//        public var original_language : String?
//        public var original_name : String?
        public var overview : String?
        public var popularity : Float?
        public var poster_path : String?
        public var production_companies : [SelectedTVDetailProductionCompany]?
        public var seasons : [SelectedTVDetailSeason]?
        public var status : String?
        public var type : String?
        public var vote_average : Float?
        public var vote_count : Int?
        
}


