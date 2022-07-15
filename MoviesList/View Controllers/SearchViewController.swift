//
//  SearchViewController.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 15/07/2022.
//

import UIKit

class SearchViewController: UIViewController {

    
    //************************************************//
    // MARK:- Creating properties
    //************************************************//
    
    var arrOfMovies = [MovieObjectViewModel]()
    
    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var pSearchBar: UISearchBar!
    @IBOutlet weak var pTableView: UITableView!

    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.pTableView.register(UINib(nibName: "SearchTableCell", bundle: nil), forCellReuseIdentifier: "SearchTableCell")

    }

    //************************************************//
    // MARK:- Custom methods, Actions and selectors.
    //************************************************//
    
    func performSearchWithQueryString(query:String)
    {
        pSearchBar.resignFirstResponder()
        self.showCustomLoader()
        APIHelper.shared.searchMovieByName(query: query) { objects, error in
            
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

}

//************************************************//
// MARK:- UISearchBar Delegate
//************************************************//

extension SearchViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text ?? ""
        if searchText.count > 0
        {
            self.performSearchWithQueryString(query: searchText)
        }
    }
}


//************************************************//
// MARK:- UITableview delegate and datasource
//************************************************//

extension SearchViewController : UITableViewDelegate , UITableViewDataSource{
    
    //************************************************//

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return arrOfMovies.count
    }
    
    //************************************************//

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  movieCell : SearchTableCell = self.pTableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
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
