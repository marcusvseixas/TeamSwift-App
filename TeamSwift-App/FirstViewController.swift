//
//  FirstViewController.swift
//  TeamSwift-App
//
//  Created by Marcus Vinicius Seixas on 11/02/16.
//
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet var MealTableView: UITableView!
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
     {
        return myItemlist.count
        
        
     }
    
    override func viewDidAppear(animated: Bool) {
        //print("viewDidAppear")
        MealTableView.reloadData()
        
    }
    
  
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
     {
        let MealTableViewCell = UITableViewCell(style: UITableViewCellStyle.Default,
                reuseIdentifier: "myCell")
        MealTableViewCell.textLabel?.text = myItemlist[indexPath.row]
        return MealTableViewCell
        
     }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       //print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

