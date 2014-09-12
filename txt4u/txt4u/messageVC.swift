//
//  ViewController.swift
//  txt4u
//
//  Created by KaL on 9/10/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

/// remove lines in tableview
/// make 2 different bubble colors for messages per user
/// have a tableView automatically start scrolled to bottom
/// show timestamp below message

class messageVC: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
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
    
    var conversation: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorColor = UIColor.clearColor()
        
        messageField.delegate = self
        
        var nC = NSNotificationCenter.defaultCenter()
        nC.addObserverForName("newMessage", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification: NSNotification!) -> Void in
            
            // update conversation and reload tableView
        })
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = conversation[indexPath.row]["content"] as String?
        return cell
    }
    
    
    var defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        println("inside will appear\(friend)")
        
        
//        conservation = defaults.arrayForKey(friend.username) as [PFObject]!
        
        var messageQuery = PFQuery(className: "Message")
        
        // when u run ur device it creates a new user
        
        // setting up an array of possible relations
        var possibleRelations = [PFUser.currentUser().username + friend.username, friend.username + PFUser.currentUser().username]
        messageQuery.whereKey("relation", containedIn: possibleRelations)

        messageQuery.findObjectsInBackgroundWithBlock { (messages: [AnyObject]!,error: NSError!) -> Void in
            
            if messages.count > 0 {
                self.conversation = messages as [PFObject]
        
                
                self.tableView.reloadData()
                
//                SIndexPath* ipath = [NSIndexPath indexPathForRow: cells_count-1 inSection: sections_count-1];
//                [tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        println(textField)
        
        formHolder.frame.origin.y = UIScreen.mainScreen().bounds.size.height - 281
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.sendMessage(textField)
        
        return true
    }
    

    @IBAction func sendMessage(sender: AnyObject) {
        
        messageField.resignFirstResponder()
        
      
        
        // PFobject is built like a dictionary so it has keys and values
        
        // created the receiver and sender here & other columns within Parse
        var message = PFObject(className: "Message")
        message["sender"] = PFUser.currentUser()
        message["receiver"] = friend
        message["content"] = messageField.text
        // relation is being created by both the sender or receiver
        message["relation"] = PFUser.currentUser().username + friend.username
        message["read"] = false
        
          println("this is the message \(message)")
        // jo + nick or nick + jo
        // have to build query to get messages, unless u build a relationship
        
        conversation.append(message)
        
        message.saveInBackground()
        tableView.reloadData()
        
        // now to push to another device
        var deviceQuery = PFInstallation.query()
        // to find in a specific device a specific user
        deviceQuery.whereKey("user", equalTo: friend)
        
        // passing through data that we log out (i think)
        var data = NSDictionary(objects: [messageField.text,friend], forKeys: ["alert","sender"])
        
        // running a push based on the device
        var push = PFPush()
//        push.setMessage(messageField.text)
        push.setQuery(deviceQuery)
        push.setData(data)
        push.sendPushInBackground() // send push async
        
        messageField.text = ""

    
    }
 


}

