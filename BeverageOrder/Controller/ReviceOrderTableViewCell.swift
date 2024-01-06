//
//  ReviceOrderTableViewCell.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/6.
//

import UIKit
import Kingfisher

class ReviceOrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var reviceImage: UIImageView!
    
    @IBOutlet weak var reviceLabel: UILabel!
    
    @IBOutlet weak var reviceSizeSegment: UISegmentedControl!
    
    @IBOutlet weak var reviceSweetLevel: UIButton!
    
    @IBOutlet weak var reviceIceLevel: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }
    
    func updateUI() {
        
        //顯示飲料圖示
        if let picUrl = URLComponents(string: "\(userInfo.records[0].fields.picURL)")?.url {
            reviceImage.kf.setImage(with: picUrl)
        }
        //顯示飲料名稱
        reviceLabel.text = userInfo.records[0].fields.beverage
        
        // 更改大小
        if userInfo.records[0].fields.size == "M" {
            reviceSizeSegment.selectedSegmentIndex = 0
        } else {
            reviceSizeSegment.selectedSegmentIndex = 1
        }
        
        //該改甜度
        //        reviceSweetLevel.menu = UIMenu()
        //        for i in 0...sugarLevelArray.count-1 {
        //            reviceSweetLevel.menu?.children.insert(contentsOf: [UIAction(title: "\(sugarLevelArray[i])", handler: { UIAction in userInfo.records[0].fields.sweetLevel = sugarLevelArray[i]
        //            })], at: i)
        //        }
        
        // 更改冰塊
            reviceIceLevel.changesSelectionAsPrimaryAction = true
            reviceIceLevel.showsMenuAsPrimaryAction = true
        if userInfo.records[0].fields.iceLevel == "熱" {
            reviceIceLevel.menu = UIMenu(children: madeMenuArray(titleArray: iceHotLevelArray))
        }else {
            reviceIceLevel.setTitle("\(userInfo.records[0].fields.iceLevel)", for: .normal)
            reviceIceLevel.menu = UIMenu(children: madeMenuArray(titleArray: iceLevelArray))
        }
    }
    
    
    func madeMenuArray(titleArray: [String]) -> [UIAction] {
        // handler設定為function型別的變數，再存入[UIAction]之中
        var menuArray = [UIAction]()
        for i in 0...titleArray.count-1 {
            menuArray.append(UIAction(title: "\(titleArray[i])",state: .on, handler: { UIAction in
                userInfo.records[0].fields.iceLevel = titleArray[i]
            }))
            
        }
        return menuArray
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
