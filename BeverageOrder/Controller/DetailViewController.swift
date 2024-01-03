//
//  DetailViewController.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/3.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    var beverageDetail = Drink(name: "", info: Infos(M: "", L: "", description: "", hotAvailable: true), picUrl: "")
    
    @IBOutlet weak var beverageImage: UIImageView!
    
    @IBOutlet weak var beverageName: UILabel!
    
    @IBOutlet weak var beverageDescribe: UILabel!
    
    @IBOutlet weak var sweetSegment: UISegmentedControl!
    
    @IBOutlet weak var iceSegment: UISegmentedControl!
    
    @IBOutlet weak var iceHotSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        fetchData()
        beverageName.text = beverageDetail.name
        beverageDescribe.text = beverageDetail.info.description
        updateSweetLevel()
        updateIceLevel()
    }
    
    
    func updateSweetLevel() {
        for i in 0...4 {
            sweetSegment.setTitle("\(sugarLevelArray[i])", forSegmentAt: i)
        }
    }
    
    func updateIceLevel() {
        if beverageDetail.info.hotAvailable {
            iceHotSegment.isHidden = false
            iceSegment.isHidden = true
            for i in 0...5 {
                iceHotSegment.setTitle("\(iceHotLevelArray[i])", forSegmentAt: i)
            }
           
        } else {
            iceHotSegment.isHidden = true
            iceSegment.isHidden = false
            for i in 0...4 {
                iceSegment.setTitle("\(iceLevelArray[i])", forSegmentAt: i)
            }
            
        }
    }
    
    func fetchData() {
        if let beverageUrl = URLComponents(string: "\(beverageDetail.picUrl)")?.url {
            beverageImage.kf.setImage(with: beverageUrl)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
