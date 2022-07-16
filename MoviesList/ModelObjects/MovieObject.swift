//
//  MovieObject.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit

struct MovieObject: Codable {

    let adult : Bool?
    let backdrop_path : String?
    let id : Int?
    let original_title : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let release_date : String?
    let title : String?
    var video : Bool?
}

struct MovieResponseResult : Codable{
    let results : [MovieObject]?
}

struct Seats_Codable: Codable{
    let hall: String?
    let time: String?
    let duration: String?
}
