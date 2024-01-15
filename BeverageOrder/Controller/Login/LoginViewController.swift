//
//  LoginViewController.swift
//  BeverageOrder
//
//  Created by stu on 2024/1/4.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var textName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapViewCloseKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func closeKeyboard(_ sender: Any) {
        
    }
    
    @IBAction func showButton(_ sender: Any) {
        if textName.text != "" {
            userInfo.records[0].fields.name = textName.text!
            print(userInfo)
            orderButton.isHidden = false
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
