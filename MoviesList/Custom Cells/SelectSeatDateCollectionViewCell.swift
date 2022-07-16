//
//  MoviesList
//
//  Created by Shoaib Hassan on 16/07/2022.
//


import UIKit

class SelectSeatDateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateBtn: UIButton!
    
    static let reuseIdentifier = "SelectSeatDateCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.dateBtn.layer.masksToBounds = true
        self.dateBtn.layer.cornerRadius = 12.0
    }

}
