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
    
    // /UUID().uuidString
    
    var isSendOrder = false
    
    @IBOutlet weak var beverageImage: UIImageView!
    
    @IBOutlet weak var beverageName: UILabel!
    
    @IBOutlet weak var beverageDescribe: UILabel!
    
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    
    @IBOutlet weak var sweetSegment: UISegmentedControl!
    
    @IBOutlet weak var iceSegment: UISegmentedControl!
    
    @IBOutlet weak var iceHotSegment: UISegmentedControl!
    
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
        if iceSegment.isHidden {
            userInfo.records[0].fields.iceLevel = iceHotLevelArray[iceHotSegment.selectedSegmentIndex]
        } else {
            userInfo.records[0].fields.iceLevel = iceLevelArray[iceSegment.selectedSegmentIndex]
        }
        print(userInfo)
       
        let alertViewController = UIAlertController(title: "訂單即將送出", message: "請最後確認", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            URLSession.shared.dataTask(with: self.uploadData()) { data, response, error in
                if let data,
                   let content = String(data: data, encoding: .utf8){
                    print("update data is successful: ", content)
                }
            }.resume()
            self.performSegue(withIdentifier: "unwindToCategoryLIst", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        present(alertViewController, animated: true)
    }
    

    
    
    func uploadData() -> URLRequest {
        let uploadUrl = URL(string: "https://api.airtable.com/v0/appYbpFNsDs7f2F3b/Table%201")!
        var urlRequest = URLRequest(url: uploadUrl)
        urlRequest.setValue("Bearer patZesgpzGmOo9ujp.508da6a245bad1153aa593349673a0a417c7350fef028d6dc7be1a235c961305", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        urlRequest.httpBody = try? encoder.encode(userInfo)
        print(urlRequest.httpBody!)
        return urlRequest
    }
    
    
    func updateUI() {
        if sizeSegment.selectedSegmentIndex == 0 {
            beveragePrice.text = beverageDetail.info.M
            userInfo.records[0].fields.price = beverageDetail.info.M
            userInfo.records[0].fields.size = "M"
        }
        beveragePrice.text = beverageDetail.info.M
        fetchData()
        beverageName.text = beverageDetail.name
        beverageDescribe.text = beverageDetail.info.description
        updateSweetLevel()
        updateIceLevel()
        sizeSegment.setTitleTextAttributes([.foregroundColor: UIColor(named: "BrownKEBUKE")!], for: .normal)
    }
    
    
    func updateSweetLevel() {
        for i in 0...4 {
            sweetSegment.setTitle("\(sugarLevelArray[i])", forSegmentAt: i)
            sweetSegment.setTitleTextAttributes([ .foregroundColor: UIColor(named: "BrownKEBUKE")!], for: .normal)
        }
    }
    
    
    func updateIceLevel() {
        if beverageDetail.info.hotAvailable {
            iceHotSegment.isHidden = false
            iceSegment.isHidden = true
            for i in 0...5 {
                iceHotSegment.setTitle("\(iceHotLevelArray[i])", forSegmentAt: i)
                iceHotSegment.setTitleTextAttributes([.foregroundColor: UIColor(named: "BrownKEBUKE")!], for: .normal)
            }
        } else {
            iceHotSegment.isHidden = true
            iceSegment.isHidden = false
            for i in 0...4 {
                iceSegment.setTitle("\(iceLevelArray[i])", forSegmentAt: i)
                iceSegment.setTitleTextAttributes([.foregroundColor: UIColor(named: "BrownKEBUKE")!], for: .normal)
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
