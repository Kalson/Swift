//
//  ViewController.swift
//  txt4u
//
//  Created by KaL on 9/10/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class messageVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var formHolder: UIView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    // were not gonna use those the prototype cell for this tableview

    var friend: PFUser! {
        
        willSet(user) {
            println("inside will set \(user)")
        }
        
        didSet(user){
            println("inside did set \(user)")
        }
    }
    
    var conservation: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conservation.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = conservation[indexPath.row]["content"] as String?
        return cell
    }
    
    
    var defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        println("inside will appear\(friend)")
        
        
//        conservation = defaults.arrayForKey(friend.username) as [PFObject]!
        
        var messageQuery = PFQuery(className: "Message")
        messageQuery.whereKey("sender", equalTo: PFUser.currentUser())
        
        messageQuery.findObjectsInBackgroundWithBlock { (messages: [AnyObject]!,error: NSError!) -> Void in
            
            if messages.count > 0 {
                self.conservation = messages as [PFObject]
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func sendMessage(sender: AnyObject) {
        
        // PFobject is built like a dictionary so it has keys and values
        
        var message = PFObject(className: "Message")
        message["sender"] = PFUser.currentUser().username
        message["receiver"] = friend
        message["content"] = messageField.text
        
        conservation.append(message)
        
        message.saveInBackground()
        tableView.reloadData()

    
    }
 


}

