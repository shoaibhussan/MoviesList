//
//  ViewController.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit
import MBProgressHUD
class ViewController: UIViewController{

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
  
    @IBOutlet weak var pTableView: UITableView!

    //************************************************//
    // MARK:- Creating properties
    //************************************************//
    
    var arrOfMovies = [MovieObjectViewModel]()
    
    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.configurViewLayoout()
    }
    
    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
 
    func configurViewLayoout(){
       
        self.title = "Watch"
        self.pTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        let searchBtn : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(self.searchFunction))
        self.navigationItem.rightBarButtonItem = searchBtn
        self.getDataFromAPI()
    }

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
                self.pTableView.reloadData()
            }
        }
    }
    
    //************************************************//

    @objc func searchFunction(){
        let vcObject = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        vcObject?.arrOfMoviesForCollectinView = self.arrOfMovies
        self.navigationController?.pushViewController(vcObject!, animated: true)
    }

    //************************************************//

}

//************************************************//
// MARK:- UITableview delegate and datasource
//************************************************//

extension ViewController : UITableViewDelegate , UITableViewDataSource{
    
    //************************************************//

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrOfMovies.count
    }
    
    //************************************************//

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  movieCell : HomeTableViewCell = self.pTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        movieCell.setDataModelView(model: arrOfMovies[indexPath.row])
        return movieCell
    }
    
    //************************************************//

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        let vcObject = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vcObject.selectedMovieId = arrOfMovies[indexPath.row].id
        self.navigationController?.pushViewController(vcObject, animated: true)
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

