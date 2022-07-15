//
//  APIHelper.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit
import Alamofire
//***************************************************//
let serverAddress = "https://api.themoviedb.org/3/movie/"

let apiKey = "afbb01db23d6d951b34de9797a2c1acd"


enum  APIEndPoints : String {
    
    // API Endpoints
    case upcoming = "upcoming"
    case videos = "videos"
    case search = "search/movie"

}

//************************************************//
// MARK:- API Call helperes
//************************************************//

class APIHelper: NSObject {

    //************************************************//
    
    static let shared = APIHelper()
    
    //************************************************//
    
    func getHomeScreenAPIReponse(completion: @escaping([MovieObject]?,Error?) -> ()){
      
        // Shoaib :: First of all we need to check internet connectivity.
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)! {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            completion(nil,error)
            return
        }
        
        let urlString = serverAddress + APIEndPoints.upcoming.rawValue + "?api_key=\(apiKey)"
        guard let url = URL (string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let err = error {
                    completion(nil,err)
                }
                else{
                    guard let data = data else {return}
                    do
                    {
                        let result = try JSONDecoder().decode(MovieResponseResult.self, from: data)
                        completion(result.results,nil)
                    }
                    catch let jsonError{
                        print(jsonError)
                    }
                    print(data)
                }
            }
        }.resume()
        
    }
    
    //************************************************//
    
    func getImagePathFromString(path:String) -> String{
        return "https://image.tmdb.org/t/p/w780/" + path
    }
    
    //************************************************//
    
    func getMovieDetailsForId(movieId:Int , completion: @escaping(MovieDetailObject?,Error?) -> ()){
       
        // Shoaib :: First of all we need to check internet connectivity.
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)! {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            completion(nil,error)
            return
        }
        
        let urlString = serverAddress + "\(movieId)" + "?api_key=\(apiKey)"
        guard let url = URL (string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let err = error {
                    completion(nil,err)
                }
                else{
                    guard let data = data else {return}
                    do
                    {
                        let result = try JSONDecoder().decode(MovieDetailObject.self, from: data)
                        completion(result,nil)
                    }
                    catch let jsonError{
                        print(jsonError)
                    }
                    print(data)
                }
            }
        }.resume()
    }
    
    //************************************************//

    
    func getMovieVideosForId(movieId:Int , completion: @escaping([MovieDetailVideo]?,Error?) -> ()){
       
        // Shoaib :: First of all we need to check internet connectivity.
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)! {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            completion(nil,error)
            return
        }
        
        let urlString = serverAddress + "\(movieId)" + "/\(APIEndPoints.videos.rawValue)" + "?api_key=\(apiKey)"
        guard let url = URL (string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let err = error {
                    completion(nil,err)
                }
                else{
                    guard let data = data else {return}
                    do
                    {
                        let result = try JSONDecoder().decode(MovieDetailsVideoResult.self, from: data)
                        completion(result.results,nil)
                    }
                    catch let jsonError{
                        print(jsonError)
                    }
                    print(data)
                }
            }
        }.resume()
    }
    

    //************************************************//
    
    func searchMovieByName(query:String , completion: @escaping([MovieObject]?,Error?) -> ()){
      
        // Shoaib :: First of all we need to check internet connectivity.
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)! {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            completion(nil,error)
            return
        }
        
        let queryTrimmed = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "https://api.themoviedb.org/3/" + APIEndPoints.search.rawValue + "?api_key=\(apiKey)" +
        "&query=\(queryTrimmed ?? " ")"
        guard let url = URL (string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let err = error {
                    completion(nil,err)
                }
                else{
                    guard let data = data else {return}
                    do
                    {
                        let result = try JSONDecoder().decode(MovieResponseResult.self, from: data)
                        completion(result.results,nil)
                    }
                    catch let jsonError{
                        print(jsonError)
                    }
                    print(data)
                }
            }
        }.resume()
        
    }
    
    //************************************************//

    func getPlaceHolderImage()->UIImage{
        return UIImage(named: "placeHolder") ?? UIImage()
    }
    
    
}
