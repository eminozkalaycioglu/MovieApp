

import Foundation

//MARK: - SelectedTVVideoModel
public struct SelectedTVVideoModel : Decodable {

        public var id : Int?
        public var results : [SelectedTVVideoResult]?
        
}

public struct SelectedTVVideoResult : Decodable {

        public var id : String?
        public var iso31661 : String?
        public var iso6391 : String?
        public var key : String?
        public var name : String?
        public var site : String?
        public var size : Int?
        public var type : String?
        
}

