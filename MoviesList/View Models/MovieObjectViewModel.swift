//
//  MovieObjectViewModel.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit

class MovieObjectViewModel: NSObject {

    let adult : Bool?
    let backDropPath : String?
    let id : Int?
    let originalTitle : String?
    let overview : String?
    let popularity : Double?
    let posterPath : String?
    let releaseDate : String?
    let title : String?
    var video : Bool?
    
    init(model:MovieObject)
    {
        self.adult = model.adult
        self.backDropPath = model.backdrop_path
        self.id = model.id
        self.originalTitle = model.original_title
        self.overview = model.overview
        self.popularity = model.popularity
        self.posterPath = model.poster_path
        self.releaseDate = model.release_date
        self.title = model.title
        self.video = model.video
    }
}
