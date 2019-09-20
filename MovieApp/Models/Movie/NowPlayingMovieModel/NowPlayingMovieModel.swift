//
//  NowPlayingMovieModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 9, 2019

import Foundation

//MARK: - NowPlayingMovieModel
public struct NowPlayingMovieModel : Decodable {

        public var dates : NowPlayingMovieDate?
        public var page : Int?
        public var results : [NowPlayingMovieResult]?
        public var total_pages : Int?
        public var total_results : Int?
        
}
