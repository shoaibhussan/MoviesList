//
//  ViewController.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit
import MBProgressHUD
class ViewController: UIViewController {

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    //************************************************//
    // MARK:- Creating properties
    //************************************************//
    
    var arrOfMovies = [MovieObjectViewModel]()
    
    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromAPI()
    }
    
    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    func getDataFromAPI(){
       
        self.showCustomLoader()
        APIHelper.shared.getHomeScreenAPIReponse { objects, error in
            self.hideCustomLoader()
            if error != nil{
                self.showErrorAlertWithError(errorMessage: error?.localizedDescription ?? "Something went wrong")
            }
            else{
                self.arrOfMovies = objects?.map({ return MovieObjectViewModel(model: $0)
                }) ?? []
            }
        }
    }

}


//************************************************//
// MARK:- Adding extension to UIViewController
//************************************************//


extension UIViewController{

    //************************************************//

    func showCustomLoader() {
        MBProgressHUD.showAdded(to: self.view, animated: true)

    }

    //************************************************//

    func hideCustomLoader() {
        MBProgressHUD.hide(for: (self.view)!, animated: true)
    }
    
    //************************************************//

    
    func showErrorAlertWithError(errorMessage:String) {
        
        let alertController = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
 
    //************************************************//
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

}

//************************************************//

extension UIView{
    
    func addGrayBorder() {
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
}

