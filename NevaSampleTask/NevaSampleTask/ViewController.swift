//
//  ViewController.swift
//  NevaSampleTask
//
//  Created by Basavaraj D on 24/01/18.
//  Copyright © 2018 Ravi D. All rights reserved.
//

import UIKit
import SDWebImage
class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
     var listItems : [UserProfileInfoModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "UserProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "UserProfileTableViewCell")
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
        
        self.tableView.estimatedRowHeight=80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        self.GetUserProfileResults()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func GetUserProfileResults() {
        
        APIManager.sharedInstance.GETRequest(success: { (results, statusCode) in
            if let data = results.data{
                print("data",data)
                self.listItems = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }) { (errorMessage, statusCode) in
            if let txt = errorMessage{
                print("errorMessage",txt)
            }

        }
        
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UserProfileTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell") as? UserProfileTableViewCell
        
        if cell == nil{
            cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell") as? UserProfileTableViewCell
        }
        
        let model = listItems[indexPath.row]
        
        if let name = model.name{
            cell?.nameLabel.text = name
        }
        
        if let skills = model.skills{
            cell?.skillsLabel.text = skills
        }
        
       if let imageUrl = model.image {
        cell?.profileImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        
        }
        return cell!
    }
}

