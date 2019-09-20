

import Foundation

//MARK: - SelectedTVActorsModel
public struct SelectedTVActorsModel : Decodable {

        public var cast : [SelectedTVActorsCast]?
        public var crew : [SelectedTVActorsCrew]?
        public var id : Int?
        
}

public struct SelectedTVActorsCast : Decodable {

        public var character : String?
        public var credit_id : String?
        public var gender : Int?
        public var id : Int?
        public var name : String?
        public var order : Int?
        public var profile_path : String?
        
}

public struct SelectedTVActorsCrew : Decodable {

        public var creditId : String?
        public var department : String?
        public var gender : Int?
        public var id : Int?
        public var job : String?
        public var name : String?
        public var profile_path : String?
        
}
