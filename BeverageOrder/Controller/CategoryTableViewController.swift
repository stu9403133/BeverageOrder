//
//  CategoryTableViewController.swift
//  BeverageOrder
//
//  Created by stu on 2023/12/31.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var menu = [Beverage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    @IBSegueAction func moveToBeverageList(_ coder: NSCoder) -> BeverageTableViewController? {
        if let row = tableView.indexPathForSelectedRow?.row {
            let controller = BeverageTableViewController(coder: coder)
            controller?.beverageList = menu[row]
            return controller
        } else{
            return nil
        }   
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count-1
    }
    
    func fetchData() {
        let beverageUrl = "https://raw.githubusercontent.com/lebonthe/JSON_API/main/kebukeMenu.json"
        guard let beverageUrl = URL(string: beverageUrl) else {
            print("JSON is nil")
            return
        }
        URLSession.shared.dataTask(with: beverageUrl) { data, response, error in
            if let data {
                do {
                    let content = try JSONDecoder().decode([Beverage].self, from: data)
                    self.menu = content
                    print("JSON Decode scccessful: ", self.menu)
                    print(userInfo)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decode fail: ", error)
                }
            }
        }.resume()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "beverageCell", for: indexPath) as? CategoryTableViewCell
        else {
            fatalError("dequeueReusableCell LoverTableViewCell failed")
        }
        let categoryList = menu[indexPath.row]
        print("category table is: ", indexPath, categoryList)
        cell.categoryText.text = categoryList.category
        cell.categoryImage.image = UIImage(named: categoryPic[indexPath.row])
        cell.categoryImage.backgroundColor = UIColor(named: "LightBlueKEBUKE")
        // Configure the cell...
        return cell
    }
    
    
    // 判斷是否已經有訂單了，跳出修改頁面
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("刪除後是空值嗎", userInfo.records.isEmpty)
        if sender is UIButton {
            if shouldReviseOrder() {
                return true
            } else {
                let alertNoOrderController = UIAlertController(title: "你還沒有訂單喔", message: "請繼續點餐", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default)
                alertNoOrderController.addAction(okAction)
                present(alertNoOrderController, animated: true)
                return false
            }
        }
        return true
    }
    
    @IBAction func unwindToCategory(for unwindSegue: UIStoryboardSegue) {
    
    }

    
    @IBSegueAction func sendSegueID(_ coder: NSCoder) -> ReviceOrderTableViewController? {
        let controller = ReviceOrderTableViewController(coder: coder)
        controller?.segueID = "categoryToRevise"
        
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
