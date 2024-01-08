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
        
        //更改甜度
        reviceSweetLevel.changesSelectionAsPrimaryAction = true
        reviceSweetLevel.showsMenuAsPrimaryAction = true
        reviceSweetLevel.menu = UIMenu(children: madeMenuArray(titleArray: sugarLevelArray, defaultString: userInfo.records[0].fields.sweetLevel))
                
        // 更改冰塊
        reviceIceLevel.changesSelectionAsPrimaryAction = true
        reviceIceLevel.showsMenuAsPrimaryAction = true
        if userInfo.records[0].fields.iceLevel == "熱" {
            reviceIceLevel.menu = UIMenu(children: madeMenuArray(titleArray: iceHotLevelArray, defaultString: userInfo.records[0].fields.iceLevel))
        } else {
            reviceIceLevel.menu = UIMenu(children: madeMenuArray(titleArray: iceLevelArray, defaultString: userInfo.records[0].fields.iceLevel))
        }
    }
    
    
    func madeMenuArray(titleArray: [String], defaultString: String) -> [UIAction] {
        // handler設定為function型別的變數，再存入[UIAction]之中
        var menuArray = [UIAction]()
        for i in 0...titleArray.count-1 {
            //利用回圈去製作menu中每一個button選項，預設handler都為.off
            menuArray.append(UIAction(title: "\(titleArray[i])", state: .off, handler: { UIAction in
                userInfo.records[0].fields.iceLevel = titleArray[i]
            }))
        }
        
        if let num = titleArray.firstIndex(of: defaultString) {
            menuArray[num].state = .on
        }
        return menuArray
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
