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
    
    var sweetDefaultString: String!
    
    var iceDefaultString: String!
    
    var indexCell: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }
    
    @IBAction func changeSize(_ sender: Any) {
        print("indexCell: ",indexCell!, "/nuserRevise.count: ", userRevise.records.count, "userInfoOrdered: ", userInfoOrdered)
        if reviceSizeSegment.selectedSegmentIndex == 0 {
            userRevise.records[indexCell].fields.size = "M"
        } else {
            userRevise.records[indexCell].fields.size = "L"
        }
        
    }
    
    @IBAction func changeSweet(_ sender: Any) {
        userRevise.records[indexCell].fields.sweetLevel = (reviceSweetLevel.titleLabel?.text)!
    }
    
    
    @IBAction func changeIce(_ sender: Any) {
        userRevise.records[indexCell].fields.iceLevel = (reviceIceLevel.titleLabel?.text)!
    }
    
    
    
    func updateUI() {
        //顯示飲料圖示
        if let picUrl = URLComponents(string: "\(userInfoOrdered.records[indexCell].fields.picURL)")?.url {
            reviceImage.kf.setImage(with: picUrl)
        }

        // 顯示飲料名稱
        reviceLabel.text = userInfoOrdered.records[indexCell].fields.beverage
        
        // 更改大小 的view
        if userInfoOrdered.records[indexCell].fields.size == "M" {
            reviceSizeSegment.selectedSegmentIndex = 0
        } else {
            reviceSizeSegment.selectedSegmentIndex = 1
        }
        
        //更改甜度
        reviceSweetLevel.changesSelectionAsPrimaryAction = true
        reviceSweetLevel.showsMenuAsPrimaryAction = true
        reviceSweetLevel.menu = UIMenu(children: madeMenuArray(titleArray: sugarLevelArray, defaultString: sweetDefaultString))
        
        // 更改冰塊
        reviceIceLevel.changesSelectionAsPrimaryAction = true
        reviceIceLevel.showsMenuAsPrimaryAction = true
        if iceDefaultString == "熱" {
            reviceIceLevel.menu = UIMenu(children: madeMenuArray(titleArray: iceHotLevelArray, defaultString: iceDefaultString))
        } else {
            reviceIceLevel.menu = UIMenu(children: madeMenuArray(titleArray: iceLevelArray, defaultString: iceDefaultString))
        }
        print(userRevise)
    }
    
    
    func madeMenuArray(titleArray: [String], defaultString: String) -> [UIAction] {
        
        var menuArray = [UIAction]()
        for i in 0...titleArray.count-1 {
            //利用回圈去製作menu中每一個button選項，預設handler都為.off
            menuArray.append(UIAction(title: "\(titleArray[i])", state: .off, handler: { UIAction in
                if titleArray == sugarLevelArray {
                    userRevise.records[self.indexCell].fields.sweetLevel  = titleArray[i]
                } else {
                    userRevise.records[self.indexCell].fields.iceLevel  = titleArray[i]
                }
                
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
