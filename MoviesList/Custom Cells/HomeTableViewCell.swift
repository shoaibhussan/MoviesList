//
//  HomeTableViewCell.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 14/07/2022.
//

import UIKit
import SDWebImage
class HomeTableViewCell: UITableViewCell {

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
        pImageView.clipsToBounds = true
        pImageView.layer.cornerRadius = 10
        
        pImageView.makeGradient()
    
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
        pImageView.sd_setImage(with: url)
     
    }
}

extension UIImageView{
    func makeGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 30, height: 160)
        gradient.contents = self.image?.cgImage
        gradient.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.addSublayer(gradient)
    }

}

