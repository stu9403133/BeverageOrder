//
//  ReviceOrderTableViewController.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/6.
//

import UIKit

// 這裡呈現的資料本來就是要去抓airtable裡使用者自己訂購的
class ReviceOrderTableViewController: UITableViewController {
    
    var segueID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRevise = userInfoOrdered
    }
    
    // MARK: - Table view data source
    @IBAction func saveOrder(_ sender: Any) {
        performSegue(withIdentifier: segueID, sender: nil)
        // 要寫patch的程式去更改後台資料
        print("user revise: ", userRevise)
        userInfoOrdered = userRevise
        print("user save, userInfoOrdered: ", userInfoOrdered)
        
        AirtableService.shared.httpCRUD(urlRequest: urlRequestOfReviseData(userInfoRevise: readyPostBody())) { result in
            switch result{
            case .success(let data):
                let content = String(data: data, encoding: .utf8)
                print("Revise order successful", content!)
            case .failure(let networkError):
                switch networkError{
                case .invaildData:
                    print(networkError)
                case .invaildResponse:
                    print(networkError)
                }
            }
        }
        
//        URLSession.shared.dataTask(with: urlRequestOfReviseData(userInfoRevise: readyPostBody())) { data, response, error in
//            if let data {
//                let content = String(data: data, encoding: .utf8)
//                print(content!)
//            }
//        }.resume()
    }
    
    // 將修改好的資料轉為符合POST格式的型別
    func readyPostBody() -> ReviseRecord {
        print(userInfoOrdered.records)
        var reviseRecord = ReviseRecord(records: [])
        
        // 依照最終訂單去創建PATCH資歷要有的records數量
        print(reviseRecord)
        for i in 0..<userInfoOrdered.records.count {
            reviseRecord.records.append(ReviseOrder(id: "", fields: OrderInfo(name: "", beverage: "", sweetLevel: "", iceLevel: "", size: "", price: "", userID: UUID(), picURL: "")))
            // 接著把要更改的值傳給要PATCH的資料
            reviseRecord.records[i].id = userInfoOrdered.records[i].id
            reviseRecord.records[i].fields = userInfoOrdered.records[i].fields
        }
        
        
        return reviseRecord
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userInfoOrdered.records.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviseOrderTableViewCell", for: indexPath) as? ReviceOrderTableViewCell else {
            fatalError("dequeueReusableCell LoverTableViewCell failed")
        }
       
        //傳入要顯示哪一row的cell
        cell.indexCell = indexPath.row
        
        //更改甜度
        cell.sweetDefaultString = userInfoOrdered.records[indexPath.row].fields.sweetLevel
        
        // 更改ice
        cell.iceDefaultString = userInfoOrdered.records[indexPath.row].fields.iceLevel
        cell.updateUI()
        return cell
    }
    
    
    // 關於表格Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let deleteID = userInfoOrdered.records[indexPath.row].id
        
        userInfoOrdered.records.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.reloadData()
        
        userRevise = userInfoOrdered
        
        URLSession.shared.dataTask(with: urlRequestOfDeleteData(recordID: deleteID)) { data, response, error in
            if let data,
               let content = String(data: data, encoding: .utf8) {
                print(content)
            }
        }.resume()
        
        if userInfoOrdered.records.isEmpty {
            isOrdered = false
        }
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
