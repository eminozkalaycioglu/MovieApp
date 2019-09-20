

import Foundation

//MARK: - PopularTVModel
public struct PopularTVModel : Decodable {

        public var page : Int?
        public var results : [PopularTVResult]?
        public var total_pages : Int?
        public var total_results : Int?
    
    
    
        
}

public struct PopularTVResult : Decodable {

        public var backdrop_path : String?
        public var first_air_cate : String?
        public var genre_ids : [Int]?
        public var id : Int?
        public var name : String?
        public var origin_country : [String]?
        public var original_language : String?
        public var original_name : String?
        public var overview : String?
        public var popularity : Float?
        public var poster_nath : String?
        public var vote_average : Float?
        public var vote_count : Int?
    
    
    
        
}
