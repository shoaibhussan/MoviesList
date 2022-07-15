//
//  tableCell.swift
//  YoutubeKit_Example
//
//  Created by Shoaib Hassan on 14/06/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class VideoTableCell: UITableViewCell {

    @IBOutlet weak var pResultLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
