//
//  MovieDetailObject.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit

struct MovieDetailObject: Decodable {

    let genres : [Genres]?
    let backdrop_path : String?
    let original_title : String?
    let overview : String?
    let id : Int?
}



struct Genres : Decodable{
    
    let id : Int?
    let name : String?
}



struct MovieDetailsVideoResult : Decodable{
    let results : [MovieDetailVideo]?
}

struct MovieDetailVideo:Decodable{
    let name:String?
    let key:String?
    let id :String?
}
