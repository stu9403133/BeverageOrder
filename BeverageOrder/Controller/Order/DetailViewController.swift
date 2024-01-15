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
    // UUID().uuidString
    
    var isSendOrder = false
    
    @IBOutlet weak var beverageImage: UIImageView!
    
    @IBOutlet weak var beverageName: UILabel!
    
    @IBOutlet weak var beverageDescribe: UILabel!
    
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    
    @IBOutlet weak var sweetSegment: UISegmentedControl!
    
    @IBOutlet weak var iceSegment: UISegmentedControl!
    
    @IBOutlet weak var beveragePrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func choicesize(_ sender: Any) {
        if sizeSegment.selectedSegmentIndex == 0 {
            beveragePrice.text = beverageDetail.info.M
            userInfo.records[0].fields.price = beverageDetail.info.M
            userInfo.records[0].fields.size = "M"
        } else {
            beveragePrice.text = beverageDetail.info.L
            userInfo.records[0].fields.size = "L"
            userInfo.records[0].fields.price = beverageDetail.info.L
        }
    }
    
    
    @IBAction func sendOrder(_ sender: Any) {
        userInfo.records[0].fields.beverage = beverageDetail.name
        userInfo.records[0].fields.sweetLevel = sugarLevelArray[sweetSegment.selectedSegmentIndex]
        userInfo.records[0].fields.picURL = beverageDetail.picUrl
        userInfo.records[0].fields.iceLevel = iceSegment.titleForSegment(at: iceSegment.selectedSegmentIndex) ?? ""
        print(userInfo)
        let sendAlertController = createAlert(alertTitle: "訂單即將送出", alertMessage: "請最後確認", alertOkAction: "OK", alertCancelAction: "取消")
        present(sendAlertController, animated: true)
    }
    
    
    func createAlert(alertTitle: String, alertMessage: String, alertOkAction: String, alertCancelAction: String) -> UIAlertController {
        let alertViewController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertOkAction, style: .default) {_ in
            // 結合Result type
            AirtableService.shared.httpCRUD(urlRequest: urlRequestOfUploadData(userIfno: userInfo)) { result in
                switch result {
                case .success(let data):
                    do{
                        let content = try JSONDecoder().decode(PostResponse.self, from: data)
                        userInfoOrdered.records.insert(contentsOf: content.records, at: 0)
                        print("decode post data is successful: ", userInfoOrdered.records.count, userInfoOrdered)
                    } catch {
                        print("decode failed: ", error)
                    }
                case .failure(let networkError):
                    switch networkError {
                    case .invaildData:
                        print(networkError)
                    case .invaildResponse:
                        print(networkError)
                    }
                }
            }
            // 送出訂單，因此可以打開購物車，所以toggle讓Bool值改變
            isOrdered = true
            self.performSegue(withIdentifier: "unwindToCategoryLIst", sender: nil)
        }
        let cancelAction = UIAlertAction(title: alertCancelAction, style: .cancel)
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        return alertViewController
    }
    
    
    func updateUI() {
        // 抓取飲料圖片，並更新在UI上
        fetchData()
        // 更新UI的飲料名稱與飲料描述
        beverageName.text = beverageDetail.name
        beverageDescribe.text = beverageDetail.info.description
        // 自定義更新甜度冰塊與size的UI
        updateSizeSegment()
        updateSweetLevel()
        updateIceLevel()
        // 更新UI的價錢
        beveragePrice.text = beverageDetail.info.M
    }
    
    func fetchData() {
        if let beverageUrl = URLComponents(string: "\(beverageDetail.picUrl)")?.url {
            beverageImage.kf.setImage(with: beverageUrl)
        }
    }
    
    func updateSizeSegment() {
        if sizeSegment.selectedSegmentIndex == 0 {
            beveragePrice.text = beverageDetail.info.M
            userInfo.records[0].fields.price = beverageDetail.info.M
            userInfo.records[0].fields.size = "M"
        }
        changeSegmentTitleColor(segment: sizeSegment, colorName: "BrownKEBUKE")
    }
    
    
    func updateSweetLevel() {
        for i in 0...4 {
            sweetSegment.setTitle("\(sugarLevelArray[i])", forSegmentAt: i)
        }
        changeSegmentTitleColor(segment: sweetSegment, colorName: "BrownKEBUKE")
    }
    
    
    func updateIceLevel() {
        for i in 0...4 {
            iceSegment.setTitle("\(iceLevelArray[i])", forSegmentAt: i)
        }
        if beverageDetail.info.hotAvailable {
            iceSegment.insertSegment(withTitle: "熱", at: iceLevelArray.count, animated: false)
        }
        changeSegmentTitleColor(segment: iceSegment, colorName: "BrownKEBUKE")
    }
    
    
    
    
    
    func changeSegmentTitleColor(segment: UISegmentedControl, colorName: String) {
        segment.setTitleTextAttributes([.foregroundColor: UIColor(named: colorName)!], for: .normal)
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
