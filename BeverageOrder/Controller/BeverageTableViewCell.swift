//
//  BaverageTableViewCell.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/2.
//

import UIKit
import Kingfisher

class BeverageTableViewCell: UITableViewCell {

    @IBOutlet weak var beverageImage: UIImageView!
    @IBOutlet weak var beverageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
