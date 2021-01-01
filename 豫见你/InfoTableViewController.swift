//
//  InfoTableViewController.swift
//  
//
//  Created by KevinXu on 2020/5/29.
//

import UIKit

class InfoViewController: UIViewController {
    var queryResult:[[String:AnyObject]]?
    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var Label_Name: UILabel!
    @IBOutlet weak var Label_ID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sqlite = SQLiteManager.sharedInstance
        sqlite.openDB()
        queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM info;")
        sqlite.closeDB()
        imgview.image = UIImage(imageLiteralResourceName:"许静宇.jpg")
        Label_Name.text = queryResult?[0]["name"]! as? String
        Label_ID.text = queryResult?[0]["ID"]! as? String
        // Do any additional setup after loading the view.
    }
}
