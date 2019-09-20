//
//  SelectedMoviesImagesModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 9, 2019

import Foundation

//MARK: - SelectedMoviesImagesModel
public struct SelectedMoviesImagesModel : Decodable {

        public var backdrops : [SelectedMoviesImagesBackdrop]?
        public var id : Int?
        public var posters : [SelectedMoviesImagesPoster]?
    
    
    enum CodingKeys : String, CodingKey {
        case backdrops = "backdrops"
        case id = "id"
        case posters = "posters"
    }
        
}
