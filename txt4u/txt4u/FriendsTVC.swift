//
//  FriendsTVC.swift
//  txt4u
//
//  Created by KaL on 9/10/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class FriendsTVC: UITableViewController {
    
    var friends: [PFUser] = []
    //     var friends: [PFUser]! -> this equals nil


    override func viewDidLoad() {
        super.viewDidLoad()
     // anything ran here is also ran in the choose TVC b/c its a subclass of this class
        println("class = \(NSStringFromClass(self.classForCoder))")
        
        // or reflect(self).summary
        if NSStringFromClass(self.classForCoder) == "txt4u.FriendsTVC" {
            
            if PFUser.currentUser()["friends"] != nil {
                // grabbing the friends from Parse
                var queryMe = PFUser.query()
                queryMe.whereKey("username", equalTo: PFUser.currentUser().username)
                // includes all the other users data
                queryMe.includeKey("friend")
                
                // first object [0] is me, friends is the key to get back the array of PFusers
                queryMe.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
                    println(objects)
                    self.friends = objects[0]["friend"] as! [PFUser] // this is an array of PFUsers
                    self.tableView.reloadData()
                    
                }
            }
            
            var nC = NSNotificationCenter.defaultCenter()
            nC.addObserverForName("newMessage", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification: NSNotification!) -> Void in
                
                // make friend have a different color if with unread message
            })
         
        }
        
   
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        tableView.registerClass(cellClass: AnyClass, forCellReuseIdentifier: "friendCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return friends.count
        // if you dont use self in swift getter and setter are not ran
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as! UITableViewCell

        var friend = friends[indexPath.row] as PFUser
        
        cell.textLabel!.text = friend.username
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // sender here is the cell we just tap
        
        if segue.identifier == "showConversation"{
            // any segue that doesn't have an identifier will crash, unless every segue is named
            var messageViewC = segue.destinationViewController as! messageVC
            messageViewC.friend = friends[self.tableView.indexPathForCell(sender as! UITableViewCell)!.row]
            // this method return an indexpath so no need to create one
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
