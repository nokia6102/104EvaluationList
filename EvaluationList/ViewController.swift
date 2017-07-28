//
//  ViewController.swift
//  EvaluationList
//
//  Created by leo_unision on 2017/7/23.
//  Copyright © 2017年 unision. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
 
    var ref : DatabaseReference!
    var floatStars : Float!
    var arrTable = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(fromURL: "https://myfirebase-c064c.firebaseio.com/").child("test")
        
        obsRead1()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    func obsRead1()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
      
            for child in snapshot.children
            {
                let Value:DataSnapshot = child as! DataSnapshot
                print ( "> \(Value.value!)" )
                let  myValue = Value.value!
                
                if let dictionary  = myValue as? [String : Any]
                {
                     self.arrTable.append(dictionary)
                    
                    if let description = dictionary["Description"] as? String
                    {
                        print("1.Description: \(description)")
                    }
                    if let stars = dictionary["stars"] as? Float
                    {
                        print("2.stars: \(stars)")
                    }
                }
                
            }
            
            print("all:\(self.arrTable)")
            print("count:\(self.arrTable.count)")
            self.tableView.reloadData()
        })
    }


    //MARK: Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (">----------------\(arrTable.count)")
        return arrTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        print(arrTable)

        cell.starsRating?.rating = arrTable[indexPath.row]["stars"] as! Float
        cell.message.text = arrTable[indexPath.row]["Description"] as? String
        cell.name.text = arrTable[indexPath.row]["uid"] as? String
        return cell
    }
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
//        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
//        floatStars = self.floatRatingView.rating
      
    }

}

