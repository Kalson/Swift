//
//  ChooseTVC.swift
//  txt4u
//
//  Created by KaL on 9/10/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class ChooseTVC: FriendsTVC {
    
    // everything that friendTVC does, ChooseTVC inherits it as long as we don't overide it
    // this inherits the methods, but they have their own @property, its is own instance object

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // query the user class
        var friendQuery = PFUser.query()
        friendQuery.findObjectsInBackgroundWithBlock { (users: [AnyObject]!, error: NSError!) -> Void in
            // properties need to use self
            self.friends = users as [PFUser]
            self.tableView.reloadData()
        }
    }
    
    @IBAction func cancelChoose(sender: AnyObject) {
        
        // we're dismissing the navigation controller b/c thats whats being presented
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println((self.navigationController?.presentingViewController as UINavigationController).viewControllers[0])
        
        // the UINavigation has a property called viewCOntroller that has an array and the index: 0 refers to the root view controller
        
        // this line refers to navigation controllers by returning FriendsTVC
        var myOldFriends = ((self.navigationController?.presentingViewController as UINavigationController).viewControllers[0] as FriendsTVC).friends
        
        // this is long way of myOldFriends
        var presentingNavC = self.navigationController?.presentingViewController as UINavigationController
        var myFriendsTVC = presentingNavC.viewControllers[0] as FriendsTVC
//        var myFriends = myFriendsTVC.friends
        // because of the swift pointer issue
        
        myFriendsTVC.friends += [friends[indexPath.row]]
        
        // += is the same as myFriends.append
        
        // saving the friends to Parse as an array of users (as a one to many relationship)
        var user = PFUser.currentUser()
        user["friend"] = myFriendsTVC.friends
        user.saveInBackground()
        
        // now we need to get the friends array back out
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
        
    }

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
