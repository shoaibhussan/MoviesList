//
//  MovieDetailsVC.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit

class MovieDetailsVC: UIViewController {

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var pTicketsButton: UIButton!
    @IBOutlet weak var pWatchNowButton: UIButton!
    @IBOutlet weak var pImageView: UIImageView!
    @IBOutlet weak var pTitleLabel: UILabel!
    @IBOutlet weak var pOverViewLabel: UILabel!
    @IBOutlet weak var pGenreCollectionView: UICollectionView!

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    var selectedMovieId : Int?
    var pCollectionGenresData = [Genres]()
    
    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayoutForView()
    }
    
    //************************************************//

    func setupLayoutForView(){
        
        self.pGenreCollectionView.register(UINib(nibName: "GenresCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GenresCollectionCell")
        
        pTicketsButton.clipsToBounds = true
        pTicketsButton.layer.cornerRadius = 5.0
        
        pWatchNowButton.clipsToBounds = true
        pWatchNowButton.layer.cornerRadius = 5.0
        pWatchNowButton.layer.borderWidth = 2.0
        pWatchNowButton.layer.borderColor = UIColor(red: 50/255.0, green: 173/255.0, blue: 230/255.0, alpha: 1.0).cgColor
        self.getDataFromAPI()
    }
    
    //************************************************//

    func getDataFromAPI(){
        
        showCustomLoader()
        APIHelper.shared.getMovieDetailsForId(movieId: selectedMovieId ?? 0) { response, error in
            
            self.hideCustomLoader()
            if error != nil{
                self.showErrorAlertWithError(errorMessage: error?.localizedDescription ?? "Something went wrong")
            }
            else
            {
                self.parseDataToUI(model: MovieDetailViewModel(model: response!))
            }
        }
    }
    
    //************************************************//

    func parseDataToUI(model:MovieDetailViewModel) {
        
        pTitleLabel.text = model.original_title
        pOverViewLabel.text = model.overview
        let imageUrl = APIHelper.shared.getImagePathFromString(path: model.backdrop_path ?? "")
        guard let url = URL (string: imageUrl) else{return}
        pImageView.sd_setImage(with: url, placeholderImage: APIHelper.shared.getPlaceHolderImage())
        pCollectionGenresData = model.genres ?? []
        pGenreCollectionView.reloadData()
    }
    
    //************************************************//
    
    @IBAction func watchTrailerAction(_ sender: Any) {
        
        showCustomLoader()
        APIHelper.shared.getMovieVideosForId(movieId: selectedMovieId ?? 0) { response, error in
            self.hideCustomLoader()
            if error != nil{
                self.showErrorAlertWithError(errorMessage: error?.localizedDescription ?? "Something went wrong")
            }
            else
            {
                let vcObjbect = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
                vcObjbect?.tableData = response?.map({ return MovieVideoViewModel(model: $0)
                }) ?? []
                self.navigationController?.pushViewController(vcObjbect!, animated: true)
            }
        }
    }

    //************************************************//

    @IBAction func bookTicketAction(_ sender: Any) {
        self.showErrorAlertWithError(errorMessage: "This module is under construction")
    }
    //************************************************//

}

//************************************************//
// MARK:- Collection view delegate and datasource
//************************************************//

extension MovieDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return pCollectionGenresData.count
    }
    
    //************************************************//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell : GenresCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionCell", for: indexPath) as! GenresCollectionCell
            cell.setDataModelForView(model: pCollectionGenresData[indexPath.item])
            return cell
     }
    
    //************************************************//

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 30)
    }
    
    //************************************************//

    
}



