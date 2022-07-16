//
//  SeacrchCollectionViewCell.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 16/07/2022.
//

import UIKit

class SeacrchCollectionViewCell: UICollectionViewCell {

    
    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var pTitleLabel: UILabel!
    @IBOutlet weak var pImageView: UIImageView!
    
    //************************************************//
    // MARK:- View life cycle
    //************************************************//
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewWithTag(10)?.clipsToBounds = true
        self.viewWithTag(10)?.layer.cornerRadius = 10
    }

    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    func setDataModelView(model:MovieObjectViewModel) {
      
        pTitleLabel.text = model.title
        let imageUrl = APIHelper.shared.getImagePathFromString(path: model.backDropPath ?? "")
        guard let url = URL (string: imageUrl) else{return}
        pImageView.sd_setImage(with: url)
     
    }
    
    //************************************************//

}
