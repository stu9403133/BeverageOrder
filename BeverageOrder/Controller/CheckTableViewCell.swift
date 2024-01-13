//
//  CheckTableViewCell.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/12.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var orderImage: UIImageView!
    
    @IBOutlet weak var orderBeverage: UILabel!
    
    @IBOutlet weak var orderName: UILabel!
    
    @IBOutlet weak var orderIceSweet: UILabel!
    
    @IBOutlet weak var orderSize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
