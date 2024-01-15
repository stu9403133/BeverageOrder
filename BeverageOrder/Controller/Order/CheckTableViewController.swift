//
//  CheckTableViewController.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/10.
//

import UIKit
import Kingfisher

class CheckTableViewController: UITableViewController {

    
    var retrieveData = RetrieveData(records: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // 這裡的fetchData是抓資料下來檢視
    // 問題這裡抓到的資料，是整筆airtable的資料>>應該是要根據使用者id抓回訂單資料而已
    func fetchData() {
        URLSession.shared.dataTask(with: urlRequestOfRetrieveData()) { [self] data, response, error in
            if let data,
               let content = String(data: data, encoding: .utf8) {
                print("try to get data successful: ", content)
                do{
                    let content = try JSONDecoder().decode(RetrieveData.self, from: data)
                    self.retrieveData = content
                    print(retrieveData)
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                } catch {
                    print("decode data failed: ", error)
                }
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return retrieveData.records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckTableViewCell", for: indexPath) as? CheckTableViewCell else {
            fatalError("dequeueReusableCell LoverTableViewCell failed")
        }
        cell.orderName.text = retrieveData.records[indexPath.row].fields.name + "你的飲料是："
        cell.orderSize.text = retrieveData.records[indexPath.row].fields.size
        cell.orderBeverage.text = retrieveData.records[indexPath.row].fields.beverage
        cell.orderIceSweet.text = "\(retrieveData.records[indexPath.row].fields.sweetLevel)" + "\(retrieveData.records[indexPath.row].fields.iceLevel)"
        if let picurl = URLComponents(string: (retrieveData.records[indexPath.row].fields.picURL))?.url {
            cell.orderImage.kf.setImage(with: picurl)
        }
        
        return cell
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
