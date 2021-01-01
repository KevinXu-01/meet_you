//
//  DB.swift
//  豫见你
//
//  Created by KevinXu on 2020/5/29.
//  Copyright © 2020 KevinXu. All rights reserved.
//

import Foundation
import UIKit

class DB{
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        
        sqlite.openDB()
        let createRestaurant = "CREATE TABLE IF NOT EXISTS restaurant('name' TEXT NOT NULL PRIMARY KEY, 'comment' TEXT);"
        let createDishes = "CREATE TABLE IF NOT EXISTS dishes('name' TEXT NOT NULL PRIMARY KEY,'restaurant' TEXT ,'price' TEXT,'description' TEXT,'pic' BLOB);"
        let createCart = "CREATE TABLE IF NOT EXISTS cart('index' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'identifier' TEXT,'name' TEXT ,'price' TEXT);"
        let createInfo = "CREATE TABLE IF NOT EXISTS info('name' TEXT NOT NULL PRIMARY KEY, 'ID' TEXT, 'pic' BLOB);"
        
        sqlite.execNoneQuerySQL(sql: createRestaurant)
        sqlite.execNoneQuerySQL(sql: createDishes)
        sqlite.execNoneQuerySQL(sql: createCart)
        sqlite.execNoneQuerySQL(sql: createInfo)
        var info:[String] = []
        info.append("INSERT OR REPLACE INTO info(name, ID) VALUES('许静宇', '2018302060052')")
        for e in info{
            sqlite.execQuerySQL(sql: e)
        }
        
        SaveImage_info(name:"许静宇", img: UIImage.init(named: "许静宇"))
        //SaveImage_info(name: "许静宇", img: UIImage.init(named: "许静宇"))

        var restaurant:[String] = []
        restaurant.append("INSERT OR REPLACE INTO restaurant(name,comment) VALUES('阳光小厨', '大众点评本地排名第1')")
        restaurant.append("INSERT OR REPLACE INTO restaurant(name,comment) VALUES('逍遥镇胡辣汤', '知名早餐连锁店')")
        for e in restaurant {
            sqlite.execNoneQuerySQL(sql: e)
        }
        var dishes:[String] = []
        dishes.append("INSERT OR REPLACE INTO dishes(name,restaurant,price,description) VALUES('八宝饭','阳光小厨','15','由糯米、豆沙、枣泥、果脯、莲心、米仁、桂圆、白糖等原料配合制成，对人体健康大有裨益。')")
        dishes.append("INSERT OR REPLACE INTO dishes(name,restaurant,price,description) VALUES('红焖羊排','阳光小厨','40','红焖羊排是一道家常菜，主要食材为羊排、西红柿等，调料为盐、生抽等。该道菜通过将食材倒入锅中小火焖炖而成。')")
        dishes.append("INSERT OR REPLACE INTO dishes(name,restaurant,price,description) VALUES('胡辣汤','逍遥镇胡辣汤','6','胡辣汤，也称糊辣汤，中原知名小吃，起源于河南省周口市西华县逍遥镇和漯河市舞阳县北舞渡镇，尤以逍遥镇胡辣汤出名，是北方早餐中常见的传统汤类名吃。')")
        dishes.append("INSERT OR REPLACE INTO dishes(name,restaurant,price,description) VALUES('黄焖鸡翅','阳光小厨','36','黄焖鸡翅是中原豫菜系，由鸡翅为主要食材做成的一道菜品，属于家常菜。该菜肉质鲜美，色香味具全，对于保持皮肤光泽、增强皮肤弹性均有好处。一般人群均可食用，老人、病人、体弱者更宜食用。')")
        dishes.append("INSERT OR REPLACE INTO dishes(name,restaurant,price,description) VALUES('油泼鲤鱼','阳光小厨','58','油泼鲤鱼是一道美味菜品，主要功效有消除水肿、利尿和补虚养身。')")
        dishes.append("INSERT OR REPLACE INTO dishes(name,restaurant,price,description) VALUES('蒸卤面','逍遥镇胡辣汤','10','蒸卤面是一款家常菜品，制作原料主要有细切面、豇豆、五花肉等。')")

        
        for e in dishes{
            sqlite.execNoneQuerySQL(sql: e)
        }
        SaveImage(name:"八宝饭", img: UIImage.init(named: "八宝饭"))
        SaveImage(name:"红焖羊排", img: UIImage.init(named: "红焖羊排"))
        SaveImage(name:"胡辣汤", img: UIImage.init(named: "胡辣汤"))
        SaveImage(name:"黄焖鸡翅", img: UIImage.init(named: "黄焖鸡翅"))
        SaveImage(name: "油泼鲤鱼", img: UIImage.init(named: "油泼鲤鱼"))
        SaveImage(name: "蒸卤面", img: UIImage.init(named: "蒸卤面"))
        sqlite.closeDB()
        //print("success!")
    }
    static func SaveImage_info(name:String,img:UIImage?){
        if img == nil{return}
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}
        let sql = "UPDATE info SET pic = ? WHERE name = '\(name)'"
        //print("UPDATE dishes SET pic = ? WHERE index = '\(name)'")
        let data = img!.jpegData(compressionQuality: 1.0) as NSData?
        sqlite.execSaveBlob(sql: sql, blob: data!)
        sqlite.closeDB()
        return
    }
    static func LoadImage_info(name:String) -> UIImage{
        let sqlite_info = SQLiteManager.sharedInstance
        let sql_info = "SELECT pic FROM info WHERE name = '\(name)'"
        let data_info = sqlite_info.execLoadBlob(sql: sql_info)
        sqlite_info.closeDB()
        return UIImage(data:data_info!)!
    }
    
    static func SaveImage(name:String,img:UIImage?){
        if img == nil{return}
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return}
        let sql = "UPDATE dishes SET pic = ? WHERE name = '\(name)'"
        //print("UPDATE dishes SET pic = ? WHERE index = '\(name)'")
        let data = img!.jpegData(compressionQuality: 1.0) as NSData?
        sqlite.execSaveBlob(sql: sql, blob: data!)
        sqlite.closeDB()
        return
    }
    
    static func LoadImage(name:String) -> UIImage{
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return UIImage(named:"nopic")!}
        let sql = "SELECT pic FROM dishes WHERE name = '\(name)'"
        let data = sqlite.execLoadBlob(sql: sql)
        sqlite.closeDB()
        return UIImage(data:data!)!
    }
}
