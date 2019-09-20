
import Foundation

//MARK: - FoundTVModel
public struct FoundTVModel : Decodable {

        public var page : Int?
        public var results : [FoundTVResult]?
        public var total_pages : Int?
        public var total_results : Int?
        
}

public struct FoundTVResult : Decodable {

        public var backdrop_path : String?
        public var first_air_date : String?
        public var genre_ids : [Int]?
        public var id : Int?
        public var name : String?
        public var origin_country : [String]?
        public var original_language : String?
        public var original_name : String?
        public var overview : String?
        public var popularity : Float?
        public var poster_path : String?
        public var vote_average : Float?
        public var vote_count : Int?
        
}
