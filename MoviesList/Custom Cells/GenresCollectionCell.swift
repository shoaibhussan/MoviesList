//
//  FilterCollectionCell.swift
//  DrIQ
//
//  Created by Shoaib Hassan on 27/07/2021.
//  Copyright © 2021 ATTech Mac. All rights reserved.
//

import UIKit

class GenresCollectionCell: UICollectionViewCell {

    //************************************************//
    // MARK:- Creating Outlets.
    //************************************************//
    
    @IBOutlet weak var pMainView: UIView!
    @IBOutlet weak var pTitleLbl: UILabel!
    
    //************************************************//
    // MARK:- View Life Cycle
    //************************************************//
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        pMainView.clipsToBounds = true
        pMainView.layer.cornerRadius = 15.0
    }
    
    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    func setDataModelForView(model : Genres)
    {
      
        pTitleLbl.text = model.name?.capitalized
        pMainView.backgroundColor = UIColor.random()
    }

    //************************************************//

}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
            alpha: 1.0
        )
    }
}
//************************************************//

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
