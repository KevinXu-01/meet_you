//
//  DetailsTableViewController.swift
//  
//
//  Created by KevinXu on 2020/5/29.
//

import UIKit

class DetailsTableViewController: UIViewController {
        var dishes:String?
        var queryResult:[[String:AnyObject]]?
        
        var addToCartDelegate:AddItemToCartDelegate?
        //@IBOutlet weak var imageview: UIImageView!
        @IBOutlet weak var imgview: UIImageView!
        @IBOutlet weak var Label_Name: UILabel!
        @IBOutlet weak var Label_Price: UILabel!
        @IBOutlet weak var Label_Description: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            let sqlite = SQLiteManager.sharedInstance
            sqlite.openDB()
            queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes WHERE name = '\(dishes!)';")
            sqlite.closeDB()
            imgview.image = DB.LoadImage(name: (queryResult?[0]["name"]! as? String)!)
            Label_Name.text = queryResult?[0]["name"]! as? String
            Label_Price.text = queryResult?[0]["price"]! as! String + "元"
            Label_Description.text = queryResult?[0]["description"]! as? String
            
            let nav = tabBarController?.viewControllers?[1] as? UINavigationController
            let secnav = nav?.viewControllers.first as? CartTableViewController
            addToCartDelegate = secnav
            // Do any additional setup after loading the view.
        }
        
        @IBAction func addToCartPressed(_ sender: UIBarButtonItem) {
            let name = Label_Name.text!
            let price = Label_Price.text!
            //print(price)
            addToCartDelegate?.addToCart(name: name, price: price)
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
