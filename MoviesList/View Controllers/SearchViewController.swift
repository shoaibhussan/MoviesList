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
    var arrOfMoviesForCollectinView = [MovieObjectViewModel]()

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var pSearchBar: UISearchBar!
    @IBOutlet weak var pTableView: UITableView!
    @IBOutlet weak var pCollectionView: UICollectionView!

    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.pTableView.register(UINib(nibName: "SearchTableCell", bundle: nil), forCellReuseIdentifier: "SearchTableCell")
        self.pCollectionView.register(UINib(nibName: "SeacrchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SeacrchCollectionViewCell")

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
                
                if self.arrOfMovies.count > 0 {
                    self.pTableView.isHidden  = false
                }
                else{
                    self.pTableView.isHidden  = true
                    self.showErrorAlertWithError(errorMessage: "No result found for seach")

                }
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
    
    //************************************************//

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        pTableView.isHidden = true
        pSearchBar.text = ""
    }
    
    //************************************************//

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


//************************************************//
// MARK:- Collection view delegate and datasource
//************************************************//

extension SearchViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrOfMoviesForCollectinView.count
    }
    
    //************************************************//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell : SeacrchCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeacrchCollectionViewCell", for: indexPath) as! SeacrchCollectionViewCell
            cell.setDataModelView(model: arrOfMoviesForCollectinView[indexPath.item])
            return cell
     }
    
    //************************************************//

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width / 2.2
        return CGSize(width: width, height: width * 0.75)
    }
    
    //************************************************//

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vcObject = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vcObject.selectedMovieId = arrOfMoviesForCollectinView[indexPath.row].id
        self.navigationController?.pushViewController(vcObject, animated: true)
    }
}
