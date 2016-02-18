//
//  MealTableViewController.swift
//  TeamSwift-App
//
//  Created by Sam Wylock on 2/17/16.
//
//

import UIKit

class MealTableViewController: UITableViewController {

    // Mark: Properties
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data

       loadSampleMeals()
    }

    func loadSampleMeals(){
        
        let photo1 = UIImage(named: "SampleBurger")!
        let meal1 = Meal(name: "Kenny Powers ate: Hamburger", photo: photo1)!
        
        let photo2 = UIImage(named: "SampleWich")!
        let meal2 = Meal(name: "Ricky Bobby ate: Sandwich", photo: photo2)!
        
        let photo3 = UIImage(named: "SampleDog")!
        let meal3 = Meal(name: "Brick Tamland ate: Hot Dog", photo: photo3)!
        
        let photo4 = UIImage(named: "SampleNoodle")!
        let meal4 = Meal(name: "Cal Naughton, Jr. ate: Noodles, Soup, Roll", photo: photo4)!
        
        let photo5 = UIImage(named: "SamplePie")!
        let meal5 = Meal(name: "Ricky Bobby ate: Pumpkin Pie", photo: photo5)!
        
        let photo6 = UIImage(named: "SampleNacho")!
        let meal6 = Meal(name: "Brick Tamland ate: Nachos", photo: photo6)!
        
        let photo7 = UIImage(named: "SamplePizza")!
        let meal7 = Meal(name: "Cal Naughton, Jr. ate: Pizza", photo: photo7)!
        
        
        meals += [meal1,meal2,meal3,meal4,meal5,meal6,meal7]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell

        // Fetches the appropriate meal for the data source layout.
        
        let meal = meals[indexPath.row]
        
        if let label = cell.nameLabel{
            label.text = meal.name
        }
        
        cell.photoImageView.image = meal.photo

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
