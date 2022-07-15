//
//  APIManager.swift
//
//  Created by Shoaib Hassan on 14/06/2022.
//

import UIKit
import Alamofire


//***************************************************//

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    //***************************************************//
    
    func restAPIGETResponse( endPoint : String , parameter:Dictionary<String, Any>, isHeader:Bool? = true, success: @escaping (_ response:Dictionary<String, Any> ) -> Void,failure: @escaping (_ error:Error) -> Void)
    {
        
        // Shoaib :: First of all we need to check internet connectivity.
        if !(NetworkReachabilityManager.init(host: "www.apple.com")?.isReachable)! {
            
            print("internet not reachable")
            let error = NSError(domain: "no internet connection", code: 500, userInfo: nil)
            failure(error)
           // failure(error.localizedDescription)
           // failure("No internet connection, please check your internet connection and try again")
            return
        }
        
        
        let serverPath = serverAddress + endPoint
        var params = parameter
        params["api_key"] = apiKey

        AF.request(serverPath, method:.get, parameters: params, encoding: URLEncoding.default).responseData{ (response) in
            DispatchQueue.main.async { 
                switch response.result {
                case .success:
                    if let successResponse = response.value as? [String: Any] {
                        print("JSON: \(response)") // serialized json response
                        if(response.response?.statusCode as? Int == 200){
                            success(successResponse)
                        }
                        else if(response.response?.statusCode as? Int == 403){
                          //  success(successResponse)
                            let errorMessage = successResponse["description"] as? String ?? ""
                           // failure(errorMessage)
                        }
                        else {
                            let errorMessage = successResponse["response"] as? String ?? "Something went wrong. Try again."
                         //   failure(errorMessage)
                        }
                    }
                case .failure(let error):
                    //failure(0,"Error")
                    print(error)
                    failure(error)
                }
            }
        }
    }
}

extension Dictionary {
    var dataRepresentation: Data? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        return theJSONData
    }
}
