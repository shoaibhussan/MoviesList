//
//  FilterCollectionCell.swift
//  DrIQ
//
//  Created by Shoaib Hassan on 27/07/2021.
//  Copyright © 2021 ATTech Mac. All rights reserved.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {

    //************************************************//
    // MARK:- Creating Outlets.
    //************************************************//
    
    @IBOutlet weak var pBadgeLbl: UILabel!
    @IBOutlet weak var pMainView: UIView!
    @IBOutlet weak var pTitleLbl: UILabel!
    
    //************************************************//
    // MARK:- View Life Cycle
    //************************************************//
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        pMainView.clipsToBounds = true
        pMainView.layer.cornerRadius = 7.0
        pMainView.layer.borderWidth = 1.0
        
        pBadgeLbl.clipsToBounds = true
        pBadgeLbl.layer.cornerRadius = pBadgeLbl.frame.size.width / 2.0
    }
    
    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    func setDataModelForView(model : FilterObject)
    {
        let badge : Int = Int(model.badgeValue) ?? 0
        if badge > 99 {
            pBadgeLbl.text = "99+"
        }
        else{
            pBadgeLbl.text = model.badgeValue
        }
        pTitleLbl.text = model.titleString.capitalized
        pBadgeLbl.backgroundColor = model.badgeColor
        let borderColor = model.isSelected ? model.badgeColor : UIColor.getLightWhite()
        pMainView.layer.borderColor = borderColor.cgColor
    }

    //************************************************//

}
