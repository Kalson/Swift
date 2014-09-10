//
//  ViewController.swift
//  txt4u
//
//  Created by KaL on 9/10/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

import UIKit

class messageVC: UIViewController {
    @IBOutlet weak var formHolder: UIView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    var friend: PFUser!
    
    var conservation: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    var defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        conservation = defaults.arrayForKey(friend.username) as [PFObject]
        
        var messageQuery = PFQuery(className: "Message")
        messageQuery.whereKey("sender", equalTo: PFUser.currentUser())
        
        messageQuery.findObjectsInBackgroundWithBlock { (messages: [AnyObject]!,error: NSError!) -> Void in
            self.conservation = messages as [PFObject]
        }
    }

    @IBAction func sendMessage(sender: AnyObject) {
        
    }
 


}

