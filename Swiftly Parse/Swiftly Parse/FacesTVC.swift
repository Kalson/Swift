//
//  FacesTVC.swift
//  Swiftly Parse
//
//  Created by KaL on 8/26/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

import UIKit

class FacesTVC: UITableViewController {
    
    var faces: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // anyobjects is a wild card
        // closure are blocka
        //  PFObject *face = [PFObject objectWithClassName:@"Faces"];
        
        
        
         Parse.setApplicationId("Ug0uF7USlfxFMKvp7YL7vByZKrXExGX4RgefVLTS", clientKey: "BY9t6o1zbwOQwgeGApDIEbUqXjUaMOchv0papqHw")
        
        self.refreshData()
        
        // this gets notification singleton
        var nc = NSNotificationCenter.defaultCenter()
        
        // anything after the "Void in" is whats in block
        nc.addObserverForName("faceSaved", object: nil, queue:NSOperationQueue.mainQueue() ) { (notification: NSNotification!) -> Void in
            
            self.refreshData()
        }
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refreshData()
    {
        var query = PFQuery(className: "Faces")
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]!, error: NSError!) -> Void in
            
            self.faces = objects
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return faces.count
        
        // to run with the getter and setter you run self in swift propert and global instance are the same
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as FaceCell
        
        var faceInfo = faces[indexPath.row] as PFObject
        
        var file = faceInfo.objectForKey("image") as PFFile
        
        cell.faceView.image = UIImage(data: file.getData())

        // Configure the cell...

        return cell
    }

    @IBAction func navButton(sender: UIBarButtonItem) {
        
//        print("hello")
        
        let navC = UINavigationController(rootViewController: IWAViewController())
        
        self.navigationController.presentViewController(navC, animated: true) { () -> Void in
            
        }
        
        
    }
}
