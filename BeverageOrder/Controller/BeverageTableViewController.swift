//
//  BeverageTableViewController.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/2.
//

import UIKit
import Kingfisher

class BeverageTableViewController: UITableViewController {
    
    var beverageList = Beverage(category: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beverageList.drinks!.count
    }
    
    //    func fetchBeveragePic() {
    //
    //    }
    
    // 產生TableView中cell的function
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeverageTableViewCell", for: indexPath) as? BeverageTableViewCell else
        {
            fatalError("dequeueReusableCell LoverTableViewCell failed")
        }
        
        // 利用print可以在小視窗檢查資料是否有成功呈現
        print(beverageList)
        
        //設定每個cell 的飲料名稱
        let item = beverageList.drinks![indexPath.row]
        cell.beverageText?.text = item.name
        
        // 抓網路圖片
        if let picUrl = URLComponents(string: "\(item.picUrl)")?.url {
            print("transfer string to url is successful: ", picUrl)
            cell.beverageImage.kf.setImage(with: picUrl)
        }else{
            print("transfer string to url is failed", item.picUrl)
        }
        
        return cell
    }
    
    @IBSegueAction func beverageCustomized(_ coder: NSCoder) -> DetailViewController? {
        var controller = DetailViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.beverageDetail = beverageList.drinks![row]
        }
        print("send data is successful", controller?.beverageDetail ?? nil)
        return controller
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
