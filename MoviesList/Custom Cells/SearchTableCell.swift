//
//  SearchTableCell.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 15/07/2022.
//

import UIKit

class SearchTableCell: UITableViewCell {

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
    }

    //************************************************//

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    func setDataModelView(model:MovieObjectViewModel) {
      
        pTitleLabel.text = model.title
        let imageUrl = APIHelper.shared.getImagePathFromString(path: model.backDropPath ?? "")
        guard let url = URL (string: imageUrl) else{return}
        pImageView.sd_setImage(with: url, placeholderImage: APIHelper.shared.getPlaceHolderImage())
     
    }
    
}
