//
//  MovieDetailViewModel.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit

class MovieDetailViewModel: NSObject {
 
    let genres : [Genres]?
    let backdrop_path : String?
    let original_title : String?
    let overview : String?
    let id : Int?
    
    init(model:MovieDetailObject){
        
        self.genres = model.genres
        self.backdrop_path = model.backdrop_path
        self.original_title = model.original_title
        self.overview = model.overview
        self.id = model.id
    }
}


class MovieVideoViewModel:NSObject{
    let name:String?
    let key:String?
    let id :String?
    
    init (model:MovieDetailVideo){
        self.name = model.name
        self.key = model.key
        self.id = model.id
    }
}
