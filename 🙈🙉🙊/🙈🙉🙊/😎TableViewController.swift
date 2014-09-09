//
//  😎TableViewController.swift
//  🙈🙉🙊
//
//  Created by KaL on 9/9/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class 😎TableViewController: UITableViewController {
    
    
//    var letters: [String]!
    var users:[String:[String]]!
    // ! sets it to be an empty dictionary
    // dictionary for the key, we want an array of keys
    
//    var d1: [String:String]!
//    var d2: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        var keys = d1.keys.array.count
//        var keys = d2.allKeys.count
        
        // swift dictionary are more simple than NSDIctionary
//        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return users.keys.array.count
        // refers to the keys of arrays
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var key = users.keys.array[section]
        var usersInSection = users[key] as Array?
        // return the value based on the key (its returning the array of strings in this case)
        
        // ? doesn't know that their is letter in the array
        return usersInSection!.count
        
        //swift dictionary is completely different than NSDictionary
        
        // ! pulls things out of the optional and lets u use that variable
        // any value within a dictionary is optional that why u need a !
    }

    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as UITableViewCell

        var key = users.keys.array[indexPath.section]
        var usersInSection = users[key]
        
        cell.textLabel?.text = usersInSection![indexPath.row]


        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
